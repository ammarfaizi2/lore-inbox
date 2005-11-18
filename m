Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVKRBjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVKRBjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVKRBji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:39:38 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:53140 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932183AbVKRBji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:39:38 -0500
Message-ID: <437D3205.3080506@student.ltu.se>
Date: Fri, 18 Nov 2005 02:44:37 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
References: <20051117111807.6d4b0535.akpm@osdl.org>
In-Reply-To: <20051117111807.6d4b0535.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1
>  
>
Got a compiler-error:

  CC      drivers/serial/jsm/jsm_tty.o
drivers/serial/jsm/jsm_tty.c: In function `jsm_input':
drivers/serial/jsm/jsm_tty.c:592: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:619: error: structure has no member named `flip'
drivers/serial/jsm/jsm_tty.c:620: error: structure has no member named `flip'
...

(in file drivers/serial/jsm/jsm_tty.c, line 592)
		flip_len = TTY_FLIPBUF_SIZE - tp->flip.count;

I could not find the patch but I tracked it to the change:


--- linux-2.6.15-rc1/include/linux/tty.h	2005-10-27 17:52:48.000000000 -0700
+++ devel/include/linux/tty.h	2005-11-17 00:55:12.000000000 -0800
@@ -74,8 +74,7 @@ struct screen_info {
 	u16 vesapm_off;		/* 0x30 */
 	u16 pages;		/* 0x32 */
 	u16 vesa_attributes;	/* 0x34 */
-	u32  capabilities;      /* 0x36 */
-				/* 0x3a -- 0x3f reserved for future expansion */
+				/* 0x36 -- 0x3f reserved for future expansion */
 };
 
 extern struct screen_info screen_info;
@@ -121,16 +120,22 @@ extern struct screen_info screen_info;
  */
 #define TTY_FLIPBUF_SIZE 512
 
-struct tty_flip_buffer {
+struct tty_buffer {
+	struct tty_buffer *next;
+	char *char_buf_ptr;
+	unsigned char *flag_buf_ptr;
+	int used;
+	int size;
+	/* Data points here */
+	unsigned long data[0];
+};
+
+struct tty_bufhead {
 	struct work_struct		work;
 	struct semaphore pty_sem;
-	char		*char_buf_ptr;
-	unsigned char	*flag_buf_ptr;
-	int		count;
-	int		buf_num;
-	unsigned char	char_buf[2*TTY_FLIPBUF_SIZE];
-	char		flag_buf[2*TTY_FLIPBUF_SIZE];
-	unsigned char	slop[4]; /* N.B. bug overwrites buffer by 1 */
+	struct tty_buffer *head;	/* Queue head */
+	struct tty_buffer *tail;	/* Active buffer */
+	struct tty_buffer *free;	/* Free queue head */
 };
 /*
  * The pty uses char_buf and flag_buf as a contiguous buffer
@@ -256,10 +261,11 @@ struct tty_struct {
 	unsigned char stopped:1, hw_stopped:1, flow_stopped:1, packet:1;
 	unsigned char low_latency:1, warned:1;
 	unsigned char ctrl_status;
+	unsigned int receive_room;	/* Bytes free for queue */
 
 	struct tty_struct *link;
 	struct fasync_struct *fasync;
-	struct tty_flip_buffer flip;
+	struct tty_bufhead buf;
 	int max_flip_cnt;
 	int alt_speed;		/* For magic substitution of 38400 bps */
 	wait_queue_head_t write_wait;

tty_flip_buffer have been split up to tty_buffer and tty_bufhead, so I do not know what the correct replacement for flip.count is.

/Richard Knutsson


