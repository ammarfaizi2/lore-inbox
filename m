Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbUKPIlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbUKPIlk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 03:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbUKPIlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 03:41:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:4015 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261940AbUKPIli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 03:41:38 -0500
Date: Tue, 16 Nov 2004 00:41:25 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       lkml <linux-kernel@vger.kernel.org>, jmorris@redhat.com
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when using SELinux and SOCK_SEQPACKET
Message-ID: <20041116004122.V14339@build.pdx.osdl.net>
References: <4197A037.1020307@blueyonder.co.uk> <1100525477.31773.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1100525477.31773.38.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Mon, Nov 15, 2004 at 08:31:17AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Sun, 2004-11-14 at 13:13, Ross Kendall Axe wrote:
> > With CONFIG_SECURITY_NETWORK=y and CONFIG_SECURITY_SELINUX=y, using
> > SOCK_SEQPACKET unix domain sockets causes an oops in the superfluous(?)
> > call to security_unix_may_send in sock_dgram_sendmsg. This patch avoids
> > making this call for SOCK_SEQPACKET sockets.
> 
> I'd prefer to track down the actual issue in the SELinux code and
> correct it than just omit the security hook call entirely.  Do you have
> the Oops output and a trivial test case?  Thanks.

Well, there is one simple case that will trigger the Oops.  Send a
SEQPACKET to a connected but not yet accepted socket.  In this case
other->sk_socket is still NULL, and SELinux will deref the NULL pointer
in selinux_socket_may_send() when geting other_isec.  There is already
a check in unix_stream_connect, which is all that's used for normal unix
stream sockets.  But the seqpacket socket then uses unix_dgram_sendmsg,
so triggers the may_send check as well.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
