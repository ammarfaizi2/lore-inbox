Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUHZN0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUHZN0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268866AbUHZNZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:25:59 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:64965 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S268851AbUHZNZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:25:54 -0400
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com>
	 <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil>
	 <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil>
	 <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil>
	 <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093526652.9280.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 26 Aug 2004 09:24:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 03:53, Kaigai Kohei wrote:
> In my understanding, your worry about robustness is the execution path
> when kmalloc() returns NULL.

Correct.

> (But avc_insert() always returns 0, because avc_insert() reclaim a avc_node
>  under the spinlock when free_list is empty.)

Yes, this is the point.  avc_has_perm could not fail previously from an
out of memory condition, as the cache nodes were preallocated,
maintained on their own freelist, and reclaimed as needed.

> By this method, the decision-making is available irrespective of
> the result of kmalloc(). Is it robustless?
> The original implementation has too many lock contensitons in Big-SMP
> environment. It is more positive to consider the method using RCU.

Yes, that would address my concern.  However, I'm still unclear as to
why using RCU mandates that we migrate from preallocated nodes to
dynamic allocation.  I certainly agree that the existing global spinlock
doesn't scale.  

> Please wait for a patch, thanks.

Thanks for working on this.  Could you also supply updated performance
data when you have a newer patch?  Thanks.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

