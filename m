Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752156AbWFLSsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbWFLSsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbWFLSse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:48:34 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:42213 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1752156AbWFLSse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:48:34 -0400
Date: Mon, 12 Jun 2006 20:48:33 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: use C code for current_thread_info()
Message-ID: <20060612184833.GA29177@rhlx01.fht-esslingen.de>
References: <200606121317_MC3-1-C23A-4F2D@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606121317_MC3-1-C23A-4F2D@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 12, 2006 at 01:14:34PM -0400, Chuck Ebbert wrote:
> Kernel code starts out ~30K bytes smaller with gcc 4.1 and using C
> for current_thread_info() helps even more than with 4.0.  Nice...

Especially since current_thread_info() often has an AGI stall (read:
severe pipeline stall) since it often cannot properly intermingle
with nearby opcodes due to lack of suitable ones, e.g. at a
function prologue.
mov    $0xffffe000,%eax
and    %esp,%eax
are fundamentally incompatible due to having to wait for the address
generation before the "and" can be executed.
This shows up during profiling quite noticeably (IIRC 8 hits vs. 1 to 2
hits on other places), which really hurts since this function is used
basically *everywhere*.
As such whatever optimization we can gain (e.g. the compiler merging
multiple current_thread_info() invocations) is very worthwhile.
I've come up with this C variant recently, too, but I didn't think
it would make too much of a difference, however it seems it's really
useful when going towards newer gcc versions. 

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
(or alternatively buy nicely packaged Linux distros/OSS software to help
support Linux developers creating shiny new things for you?)
