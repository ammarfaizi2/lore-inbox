Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVCPM6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVCPM6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVCPM6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:58:45 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:47489 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262561AbVCPM62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:58:28 -0500
Message-ID: <42382D5C.1030104@bull.net>
Date: Wed, 16 Mar 2005 13:58:04 +0100
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com
Subject: Re: Mprotect needs arch hook for updated PTE settings
References: <01EF044AAEE12F4BAAD955CB75064943032C6020@scsmsx401.amr.corp.intel.com>
In-Reply-To: <01EF044AAEE12F4BAAD955CB75064943032C6020@scsmsx401.amr.corp.intel.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/03/2005 14:07:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/03/2005 14:07:44,
	Serialize complete at 16/03/2005 14:07:44
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An application should not change the protection of its _own_ text region
without knowing well the requirements of the given architecture.
I do not think we should add anything into the kernel for this case.

I did see /lib/ld-linux-ia64.so.* changing the protection of the text
segment of the _victim_ application, when it linked the library references.
ld-linux-ia64.so.* changes the protection for the whole text segment
(otherwise, as the protection is per VMA, it would result in a VMA
fragmentation).
The text segment can be huge. There is no reason to flush all the text
segment every time when ld-linux-ia64.so.* patches an instruction and
changes the protection.

I think the solution should consist of these two measures:

1. Let's say that if an VMA is "executable", then it remains "executable"
   for ever, i.e. the mprotect() keeps the PROT_EXEC bit.
   As a result, if a page is faulted in for this VMA in the mean time, the
   old good mechanism makes sure that the I-caches are flushed.

2. Let's modify ld-linux-<arch>.so.*: having patched an instruction, it
   should take the appropriate, architecture dependent measure, e.g. for
   ia64, it should issue an "fc" instruction.

   (Who cares for a debugger ? It should know what it does ;-).)

I think there is no need for any extra flushes.

Thanks,

Zoltan Menyhart
