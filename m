Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTEITVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263416AbTEITVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:21:21 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:11764 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263415AbTEITVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:21:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: ioctl32_unregister_conversion & modules
Date: Fri, 9 May 2003 21:30:33 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030509100039$6904@gated-at.bofh.it> <200305091213.h49CDuO4029947@post.webmailer.de> <20030509152436.GA762@elf.ucw.cz>
In-Reply-To: <20030509152436.GA762@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305092130.33274.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 May 2003 17:24, Pavel Machek wrote:

> Fixing that would require resgister_ioctl32_conversion() to have 3-rd
> parameter "this module" and some magic inside fs/compat_ioctl.c,
> right?

The code that is currently using register_ioctl32_conversion() does
not have to be changed if we use 

extern int 
__register_ioctl_conversion(int, ioctl_trans_handler_t, struct module*);

static inline int 
register_ioctl_conversion(int cmd, ioctl_trans_handler_t h)
{
	return __register_ioctl_conversion(cmd, h, THIS_MODULE);
}

/* maybe also: */
static inline int 
register_compatible_ioctl(int cmd)
{
	return __register_ioctl_conversion(cmd, NULL, NULL);
}

register_compatible_ioctl() is not strictly needed, but it will avoid
doing the unnecessary try_module_get() when there is no handler.

	Arnd <><
