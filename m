Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUGMBV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUGMBV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 21:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUGMBV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 21:21:56 -0400
Received: from mail1.WPI.EDU ([130.215.36.102]:43218 "EHLO mail1.WPI.EDU")
	by vger.kernel.org with ESMTP id S264519AbUGMBVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 21:21:53 -0400
Date: Mon, 12 Jul 2004 21:21:52 -0400
From: "Charles R. Anderson" <cra@WPI.EDU>
To: linux-kernel@vger.kernel.org
Subject: Re: v2.6 IGMPv3 implementation
Message-ID: <20040713012152.GL7822@angus.ind.WPI.EDU>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040712203056.GI7822@angus.ind.WPI.EDU> <20040713.062226.130914590.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713.062226.130914590.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 06:22:26AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> These ioctls are "historic" and deprecated API.
> So, just kill them to avoid confusion.
> We use socket options.

Thank you.  I have now read RFC3678 carefully and I have more
questions.  The kernel still declares the structs used for these
obsolete ioctls, but instead defines sockoptions for them:

#define IP_MSFILTER			41
...
#define MCAST_MSFILTER			48
...
struct ip_msfilter {
	__u32		imsf_multiaddr;
	__u32		imsf_interface;
	__u32		imsf_fmode;
	__u32		imsf_numsrc;
	__u32		imsf_slist[1];
};

#define IP_MSFILTER_SIZE(numsrc) \
	(sizeof(struct ip_msfilter) - sizeof(__u32) \
	+ (numsrc) * sizeof(__u32))
...
struct group_filter
{
	__u32				 gf_interface;	/* interface index */
	struct __kernel_sockaddr_storage gf_group;	/* multicast address */
	__u32				 gf_fmode;	/* filter mode */
	__u32				 gf_numsrc;	/* number of sources */
	struct __kernel_sockaddr_storage gf_slist[1];	/* interface index */
};

#define GROUP_FILTER_SIZE(numsrc) \
	(sizeof(struct group_filter) - sizeof(struct __kernel_sockaddr_storage) \
	+ (numsrc) * sizeof(struct __kernel_sockaddr_storage))

Is it intended that glibc use these sockoptions internally for its
implementation of the approved Advanced API functions, which are then
exported to user programs:

setipv4sourcefilter()
getipv4sourcefilter()
setsourcefilter()
getsourcefilter()

Does the following limitation from RFC3678 Appendix A (rationale for
the ioctl interface) apply to the Linux kernel getsockopt(), or can
getsockopt() be used to retrieve the source filter for a given group?

   Retrieving the source filter for a given group cannot be done with
   getsockopt() on some existing platforms, since the group and
   interface must be passed down in order to retrieve the correct
   filter, and getsockopt only supports an output buffer.  This can,
   however, be done with an ioctl(), and hence for symmetry, both gets
   and sets are done with an ioctl.

Thank you for putting up with all my questions.

