Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTJUSYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTJUSYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:24:32 -0400
Received: from smtp4.Stanford.EDU ([171.67.16.29]:32231 "EHLO
	smtp4.Stanford.EDU") by vger.kernel.org with ESMTP id S263279AbTJUSYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:24:30 -0400
Message-ID: <3F9579D1.6050108@stanford.edu>
Date: Tue, 21 Oct 2003 11:24:17 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b; MultiZilla v1.5.0.1) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Glasgow <glasgow@beer.net>, linux-kernel@vger.kernel.org
Subject: Re: posix capabilities inheritance
References: <fa.hehull9.10mmngt@ifi.uio.no>
In-Reply-To: <fa.hehull9.10mmngt@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with these problems, but I think the proper fix is complicated.  AFAICT, 
POSIX capability evolution, as specified by whatever draft it was, is broken, so 
the hacks in prepare_binprm (cap_bprm_set_security in 2.6) are needed to avoid 
security problems.  Aside from the fact that non-inheritable-by-default makes 
little sense (and requires root to get capabilities re-added from the file 
_permitted_ set), POSIX cap evolution has some other problems:

1. Can a process have capabilities in its inheritable set and not in its 
permitted set?  POSIX allows such processes to be created (pI = pP = full, then 
execute (fI = 0, fP = 0).  Nevertheless, its pP evolution rule assumes that this 
never happens (pI capabilities can reappear).

2. If a process has pE < pP (i.e. some caps disabled, e.g. uid=0, euid!=0), and 
exec's fE=full, then its capabilities get re-enabled.  This seems like a pretty 
serious breakage of userspace.

I have a possible fix to these issues at 
<http://www.stanford.edu/~luto/linux-fscap/> -- CONFIG_FS_CAPS (in 
cap-1-fscap.patch) changes the capability evolution rules slightly to make them 
(IMHO) both safe and sensible, as well as removing the ugly hackage in 
set_security.  This will allow your capabilities to persist through exec().  The 
second patch (cap-2-ext3.patch) adds file capabilities to ext3.  Both are tested 
on 2.6.0-test6, and they apply with fuzz and compile (but not tested yet) on 
-test8.  (These are different from my last attempt at this -- they are much 
closer to POSIX semantics.)

Unfortunately, I think it's too late to include these in 2.6.0.

Andy

