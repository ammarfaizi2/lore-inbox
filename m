Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUCRBPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 20:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUCRBPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 20:15:03 -0500
Received: from opersys.com ([64.40.108.71]:60431 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262266AbUCRBO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 20:14:58 -0500
Message-ID: <4058F91C.9000207@opersys.com>
Date: Wed, 17 Mar 2004 20:19:24 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Mark Gross <mgross@linux.co.intel.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       lkml <linux-kernel@vger.kernel.org>, Philippe Gerum <rpm@xenomai.org>
Subject: Re: Call for HRT in 2.6 kernel was Re: finding out the value of HZ
 from userspace
References: <20040311141703.GE3053@luna.mooo.com> <200403161757.48786.mgross@linux.intel.com> <20040317023059.GD19564@mail.shareable.org> <200403170848.01156.mgross@linux.intel.com> <20040317200702.GA25293@mail.shareable.org>
In-Reply-To: <20040317200702.GA25293@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jamie Lokier wrote:
> So there is hope with HRT, but it needs more than an implementation to
> get into the standard tree (IMHO): it has to be fairly small,
> non-invasive, not harm existing performance, and backed by convincing
> experimental data showing worthwhile improvements.

Looking at the high-res timer stuff, it's somewhat similar to what
RTAI does (reprogram timer chip, use nanoseconds for computations,
provide API for ease of use, etc.) except that it can't guarantee
hard-rt, and it's integrated directly with Linux's scheduling
whereas RTAI has its own scheduler and lives as a module.

It's not my intention to debate which is better, I'll leave that
for another day. What I'm interested in, however, is that there is
a common functionality that all such facilities can use to achieve/
deliver hard-rt.

I'm thinking here of Adeos. It's the smallest subset of services
required for obtaining hard-rt in the kernel, and it's fairly
non-invasive (not to mention that configuring it out results in no
changes to the kernel.) So while Adeos doesn't provide abstract
services such as "tasks" or "timers", it does provide the basic
mechanism for all add-ons that want to provide these to obtain
the hard-rt from Adeos using an architecture-independent API.

Here are a few examples of software that can obtain hard-rt with
Adeos:
- RT Executives: Currently RTAI uses Adeos on x86 and a port of
RTLinux/GPL to Adeos is planned. Adeos, however, isn't limited to
either of these executives, and could easily be used by any other
RT executive to sit side-by-side with Linux and other kernels.
- hard-rt drivers: It's fairly trivial for a driver to hook into the
Adeos pipeline and obtain hard-rt without using either RTAI or
RTLinux. In that case, there's just the standard Linux kernel with
a hard-rt driver side-by-side atop Adeos.
- HRT: Any mechanism that modifies the PIT can then export timer
services to drivers for providing them with deterministic timer
response times. Granted there would be no integration with the
current Linux scheduler, but the added advantage is that HRT can
live as a loadable module. Scheduling/notifying of user-space
processes using such HRT is possible; RTAI's hard-rt scheduling
of normal Linux processes being an example.

Actually, most software that needs hard-rt can live as loadable
modules once Adeos is integrated in the kernel.

The Adeos patches are available here for those who are interested:
http://download.gna.org/adeos/patches/

P.S.: Before anyone comes back shouting after looking at the #ifdefs
used to modify _existing_ kernel files in the current Adeos patches,
please keep in mind that they are mainly there because they make it
fairly trivial to create patches for new kernels. When cleaning up
the patches for inclusion, most of these would disappear.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

