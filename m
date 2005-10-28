Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbVJ1VEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbVJ1VEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbVJ1VEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:04:09 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:58015 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751799AbVJ1VEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:04:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=k6cExEV1TztBFg4bPR5kvz7VTAZN5r/xvJ1vTIHYiZltL3vLiM9/2KeDd3s1pIASH1I2V+jXlZnWkSItteRum+iABMxbRYqmW5GPajmN/rpJoR1qKzqykxGCKn5ARLqfPyoyrskodfT8pxtwoYtY/lKlLaWeKMVzbnh2YGQNRI0=
Date: Sat, 29 Oct 2005 01:16:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: zoran drivers: absense of locking?
Message-ID: <20051028211647.GB7629@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to read random part of a tree and now scratching my head
with a question:

	what protects the number and a list of registered codecs in
	zoran drivers?

Example: drivers/media/video/zr36050.c:

	/* amount of chips attached via this driver */
	static int zr36050_codecs = 0;

Decremented in zr36050_unset().
Checked for maximum value, used and incremented in zr36050_setup().

[Assigment to 0 in zr36050_init_module is not needed. dprintk() in
zr36050_cleanup_module() should be converted to BUG_ON, so I'll ignore
them.]

	zr36050_codecs
		zr36050_unset()	= struct videocodec::unset
		zr36050_setup()	= struct videocodec::setup

The only place where ->unset and ->setup methods are called is
drivers/media/video/videocodec.c:

	zr36050_codecs
		zr36050_unset()
			videocodec_detach()
		zr36050_setup()
			videocodec_attach()

Both videocodec functions are exported.

No spinlocks or semaphores in sight.

Does anybody know what protects the list of registered codecs in zoran
drivers?

