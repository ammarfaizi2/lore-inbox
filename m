Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSLAQwC>; Sun, 1 Dec 2002 11:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSLAQwC>; Sun, 1 Dec 2002 11:52:02 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:42197 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262023AbSLAQwA>; Sun, 1 Dec 2002 11:52:00 -0500
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
References: <20021201083056.GJ679@kroah.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Date: Sun, 01 Dec 2002 17:59:10 +0100
Message-ID: <87k7it3cbl.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> I'm _really_ tired of all of the "empty" functions that all security
> modules need to provide.  So here's a brute force patch that lets any
> security module only set the functions that it wants to override.  If
> the function is NULL, then the "dummy" function will be used instead.
>
> What do people think of this?  I also cleaned up the comment in the
> verify function of security/security.c and made it not inline.

I second this. It's very annoying and error-prone to define lots of
unnecessary functions, not to mention maintainability.

> ===== security/security.c 1.4 vs edited =====
> --- 1.4/security/security.c	Thu Oct 17 13:21:20 2002
> +++ edited/security/security.c	Sat Nov 30 23:01:07 2002
[...]
> @@ -59,11 +61,8 @@
>  	/* Perform a little sanity checking on our inputs */
>  	err = 0;
>  
[...]
>  	VERIFY_STRUCT(struct security_operations, ops, err);

This shouldn't be necessary anymore.
 
> @@ -106,6 +105,7 @@
>   */
>  int register_security (struct security_operations *ops)
>  {
> +	security_fixup_ops (ops);

You're patching other people's data structures. Not everybody may like
this. Maybe it's even impossible on ROM based systems. Do you think a
copy is doable? Just a thought.

>  	if (verify (ops)) {
>  		printk (KERN_INFO "%s could not verify "

When ops is NULL, this check is too late.

> @@ -162,6 +162,8 @@
>   */
>  int mod_reg_security (const char *name, struct security_operations *ops)
>  {
> +	security_fixup_ops (ops);
> +
>  	if (verify (ops)) {
>  		printk (KERN_INFO "%s could not verify "
>  			"security operations.\n", __FUNCTION__);

Same here.

Nevertheless, I like this patch.

Regards, Olaf.
