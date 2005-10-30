Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVJ3LyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVJ3LyH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 06:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVJ3LyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 06:54:07 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:39630 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932092AbVJ3LyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 06:54:06 -0500
Date: Sun, 30 Oct 2005 12:54:30 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051030115430.GA2747@uio.no>
References: <20051030023557.GA7798@uio.no> <20051030101148.GA18854@outpost.ds9a.nl> <20051030104527.GB32446@uio.no> <20051030110021.GA19680@outpost.ds9a.nl> <20051030113651.GA1780@uio.no> <20051030114537.GA20564@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051030114537.GA20564@outpost.ds9a.nl>
X-Operating-System: Linux 2.6.14-rc5 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.8 (--)
X-Spam-Report: Status=No hits=-2.8 required=5.0 tests=ALL_TRUSTED version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:45:38PM +0100, bert hubert wrote:
> Check if the address passed, 0x561329b0, is very different from addresses
> passed during regular operations. The error the kernel returns basically
> says that this address is bogus, which it might be, but if more or less the
> same address worked previously chances are that the kernel is confused

Yes, I know what EFAULT means. The interesting part is that I can find one
single call to recvmsg() in the UNIX part of BIND, and there the argument is
on the stack...

strace doesn't show the address except when something fails, but these are
the distinct calls to recvmsg with given addresses (sorted):

[pid 13365] recvmsg(20, 0x56131f60, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(22, 0x56131f60, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(22, 0x56132980, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(22, 0x561329b0, 0)  = -1 EFAULT (Bad address)
[pid 13365] recvmsg(23, 0x56131ef0, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(23, 0x56132540, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(23, 0x56132870, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(23, 0x561328a0, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(23, 0x56132940, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(23, 0x561329b0, 0)  = -1 ECONNRESET (Connection reset by peer)
[pid 13365] recvmsg(26, 0x56132910, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(28, 0x561324f0, 0)  = -1 EFAULT (Bad address)
[pid 13365] recvmsg(28, 0x56132840, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[pid 13365] recvmsg(28, 0x56132840, 0)  = -1 EFAULT (Bad address)
[pid 13365] recvmsg(29, 0x56132840, 0)  = -1 EAGAIN (Resource temporarily unavailable)

Note that there's multiple EFAULTs in there, and some even go against an
address that was valid at some point... I think there's something fishy in
here.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
