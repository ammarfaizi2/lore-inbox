Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTFFNdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 09:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTFFNdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 09:33:41 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:51718 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261352AbTFFNdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 09:33:38 -0400
Subject: RE: [PATCH] megaraid driver fix for 2.5.70
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: Mark Haverkamp <markh@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185F234@EXA-ATLANTA.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E570185F234@EXA-ATLANTA.se.lsil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 06 Jun 2003 09:46:52 -0400
Message-Id: <1054907212.1777.10.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-06 at 09:28, Mukker, Atul wrote:
> Coming back to main issue, declaring complete mailbox would be superfluous
> since driver uses 16 bytes at most. The following patch should fix the panic
> 
>  	mbox = (mbox_t *)raw_mbox;
>  
> -	memset(mbox, 0, sizeof(*mbox));
> +	memset(mbox, 0, 16);
>  
>  	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
>  

This, I think, is a bad idea.  It looks intrinsically wrong to allocate
storage and assign a pointer to it of a type that is longer than the
allocated storage.  The initial buffer overrun was due to problems with
this.

I think the correct solution is to define your mailbox like this:

typedef struct {
	/* 0x0 */ u8 cmd;
	/* 0x1 */ u8 cmdid;
	/* 0x2 */ u16 numsectors;
	/* 0x4 */ u32 lba;
	/* 0x8 */ u32 xferaddr;
	/* 0xC */ u8 logdrv;
	/* 0xD */ u8 numsgelements;
	/* 0xE */ u8 resvd;
	/* 0xF */ volatile u8 busy;
} __attribute__ ((packed)) user_mbox_t;

typedef struct {
	user_mbox_t mbox_out
	/* 0x10 */ volatile u8 numstatus;
	/* 0x11 */ volatile u8 status;
	/* 0x12 */ volatile u8 completed[MAX_FIRMWARE_STATUS];
	volatile u8 poll;
	volatile u8 ack;
} __attribute__ ((packed)) mbox_t;

and then re-define the issue_scb..() routines to use user_mbox_t which
is always the correct size.

Thus, you can throw away the raw_mbox and just do

user_mbox_t mbox;
memset(&mbox, 0, sizeof(mbox));

of course, your ->busy references become ->mbox_out.busy.

James


