Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVCSUmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVCSUmR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 15:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVCSUmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 15:42:17 -0500
Received: from opersys.com ([64.40.108.71]:7948 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261772AbVCSUmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 15:42:13 -0500
Message-ID: <423C913B.6000307@opersys.com>
Date: Sat, 19 Mar 2005 15:53:15 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Baruch Even <baruch@ev-en.org>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Relayfs question
References: <Pine.LNX.4.61.0503191852520.21324@yvahk01.tjqt.qr> <423C78E8.3040200@ev-en.org> <Pine.LNX.4.61.0503192014520.14144@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0503192014520.14144@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan Engelhardt wrote:
> Ok, urandom was a bad example. I have my tty logger (ttyrpld.sf.net) which 
> moves a lot of data (depends) to userspace. It uses a ring buffer of "fixed" 
> size (set at module load time). Apart from that relayfs could use a dynamic 
> sized ring buffer, I would not see any need to move it to relayfs, would you?

First, please note that the info on Opersys' site is out-of-date. While
it was relevant while we were still maintaining relayfs separately, it
has somewhat lost its relevance since we started posting the most up-to-
date code directly to LKML. For one thing, the dynamic resizing was
dropped very early in relayfs' inclusion review.

What relayfs does, and does very well, is move very large amounts of
data out of the kernel and make them available to user-space with very
little overhead. In the actual case of your tty logger, I've browsed
through the code briefly, and I think that with relayfs you should be
able to:
- Get rid of half the code:
  - No need to manage your own user/kernel-buffer boundary (Most of the
    code in uio_*()).
  - No need to do any buffer management at all.
- Get better performance out of your logging functions.
- Get per-cpu buffers for free.

Basically, all the transport code you are doing in the kernel side of
your logger would be taken care of by relayfs. And given that there are
a lot of people doing similar ad-hoc buffering code, it just makes
sense to have one well-tested yet generic mechanism. Have a look at
Documentation/filesystems/relayfs.txt for the API details.

On a separate yet related topic:
Looking closer at rpldev.c, I believe that you'll be able to get rid of
it entirely (or very close to) once I actually get the time to refactor
the tracing code in LTT to make it generic. What I intend to do is to
obsolete the need for functions like your kio_*, and make it all
automatically generated at build time (you'll still to add the
instrumentation, but won't need to hand-code the callbacks). This is
still on the top of my to-do list and I should be able to get to this
shortly.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
