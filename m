Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbVBCJPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbVBCJPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 04:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263456AbVBCJPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 04:15:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23170 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263417AbVBCJPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 04:15:14 -0500
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: vgoyal@in.ibm.com, ebiederm@xmission.com, akpm@osdl.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com, hari@in.ibm.com, suparna@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <1106475280.26219.125.camel@2fwv946.in.ibm.com>
	<m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
	<1106833527.15652.146.camel@2fwv946.in.ibm.com>
	<20050203.160252.104031714.taka@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Feb 2005 02:13:08 -0700
In-Reply-To: <20050203.160252.104031714.taka@valinux.co.jp>
Message-ID: <m1zmym6m6z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi <taka@valinux.co.jp> writes:

> Hi Vivek and Eric,
> 
> IMHO, why don't we swap not only the contents of the top 640K
> but also kernel working memory for kdump kernel?
> 
> I guess this approach has some good points.
> 
>  1.Preallocating reserved area is not mandatory at boot time.
>    And the reserved area can be distributed in small pieces
>    like original kexec does.
> 
>  2.Special linking is not required for kdump kernel.
>    Each kdump kernel can be linked in the same way,
>    where the original kernel exists.
> 
> Am I missing something?

Preallocating the reserved area is largely to keep it from
being the target of DMA accesses.  Since we are not able
to shutdown any of the drivers in the primary kernel running
in a normal swath of memory sounds like a good way to get
yourself stomped at the worst possible time.

In addition we get to avoid running a lot of code in the
panic path if we are jumping to a contiguous region of memory 
with everything already setup.

To some extent this is a contest who has the better imagination
for things that can go wrong.  Real life on dying hardware and
kernels, or the programmers writing the diagnostic code.

But if it is a gamble you are willing to take it is quite
feasible to use the reserved region for what you are
proposing and you could run a standard kernel.

The other reason for running out of the reserved region is that
it actually requires less memory reserved.  Every byte you backup
needs to have a reserved area of memory to hold it.  And if you are
also going to fill that with meaningful content you need another
byte to hold the data.  So using a stock kernel probably requires
2/3 more memory.

Eric
