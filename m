Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTL2UOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTL2UNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:13:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29315 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263868AbTL2UN3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:13:29 -0500
Date: Mon, 29 Dec 2003 20:13:28 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Omkhar Arasaratnam <omkhar@rogers.com>
Cc: axeboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/cdrom/isp16.c check_region() fix
Message-ID: <20031229201328.GM4176@parcelfarce.linux.theplanet.co.uk>
References: <20031229194222.GA26019@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229194222.GA26019@omkhar.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 02:42:23PM -0500, Omkhar Arasaratnam wrote:
> check_region is depreciated in 2.6, this replaces it with request_region
> 
> As this is my first patch to the kernel, please let me know if I did anything wrong

It's pointless - the reason why check_region() is bad applies to your code.
The problem with check_region() is simple - it gives no protection against
somebody else grabbing the ports in question just as you've got "it's free"
from check_region().  The same problem exists with your replacement -
as soon as you've released the region it could've been grabbed by anybody.

Note that there's another problem - on rmmod we release the region we
hadn't grabbed.  Proper fix is
	a) replace check_region with request_region
	b) check that we don't have any IO on those ports before that
point (surprisingly many drivers are buggy that way - they do some IO
and then go "oops, looks like somebody held these ports after all;
oh, well, let's hope we hadn't screwed them too badly").  AFAICS isp16
is OK in that repect, though.
	c) make sure that we release that region on all failure exits
past that point, so that insmod failure would not leave it grabbed.
