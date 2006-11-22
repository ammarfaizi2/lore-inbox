Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966998AbWKVBbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966998AbWKVBbU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966981AbWKVBbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:31:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:7076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966997AbWKVBbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:31:19 -0500
Date: Tue, 21 Nov 2006 17:31:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add return value checking of get_user() in
 set_vesa_blanking()
Message-Id: <20061121173115.6d258a5a.akpm@osdl.org>
In-Reply-To: <20061121141528.234a9335.yoichi_yuasa@tripeaks.co.jp>
References: <20061121141528.234a9335.yoichi_yuasa@tripeaks.co.jp>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 14:15:28 +0900
Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:

> Hi,
> 
> This patch has added return value checking of get_user() in set_vesa_blanking().
> 
> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
>  
> diff -pruN -X generic/Documentation/dontdiff generic-orig/drivers/char/vt.c generic/drivers/char/vt.c
> --- generic-orig/drivers/char/vt.c	2006-11-21 10:23:39.409667250 +0900
> +++ generic/drivers/char/vt.c	2006-11-21 10:11:48.037209250 +0900
> @@ -3318,9 +3318,10 @@ postcore_initcall(vtconsole_class_init);
>  
>  static void set_vesa_blanking(char __user *p)
>  {
> -    unsigned int mode;
> -    get_user(mode, p + 1);
> -    vesa_blank_mode = (mode < 4) ? mode : 0;
> +	unsigned int mode;
> +
> +	if (!get_user(mode, p + 1))
> +		vesa_blank_mode = (mode < 4) ? mode : 0;
>  }
>  
>  void do_blank_screen(int entering_gfx)

How about we go all the way?

diff -puN drivers/char/vt.c~add-return-value-checking-of-get_user-in drivers/char/vt.c
--- a/drivers/char/vt.c~add-return-value-checking-of-get_user-in
+++ a/drivers/char/vt.c
@@ -152,7 +152,7 @@ static void gotoxy(struct vc_data *vc, i
 static void save_cur(struct vc_data *vc);
 static void reset_terminal(struct vc_data *vc, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
-static void set_vesa_blanking(char __user *p);
+static int set_vesa_blanking(char __user *p);
 static void set_cursor(struct vc_data *vc);
 static void hide_cursor(struct vc_data *vc);
 static void console_callback(void *ignored);
@@ -2369,7 +2369,7 @@ int tioclinux(struct tty_struct *tty, un
 			ret = __put_user(data, p);
 			break;
 		case TIOCL_SETVESABLANK:
-			set_vesa_blanking(p);
+			ret = set_vesa_blanking(p);
 			break;
 		case TIOCL_GETKMSGREDIRECT:
 			data = kmsg_redirect;
@@ -3315,9 +3315,13 @@ postcore_initcall(vtconsole_class_init);
 
 static void set_vesa_blanking(char __user *p)
 {
-    unsigned int mode;
-    get_user(mode, p + 1);
-    vesa_blank_mode = (mode < 4) ? mode : 0;
+	unsigned int mode;
+
+	if (get_user(mode, p + 1))
+		return -EFAULT;
+
+	vesa_blank_mode = (mode < 4) ? mode : 0;
+	return 0;
 }
 
 void do_blank_screen(int entering_gfx)
_

