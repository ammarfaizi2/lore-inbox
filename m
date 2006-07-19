Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWGSURz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWGSURz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 16:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWGSURz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 16:17:55 -0400
Received: from waha.wetafx.co.nz ([210.55.0.200]:50111 "EHLO waha.wetafx.co.nz")
	by vger.kernel.org with ESMTP id S1030269AbWGSURx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 16:17:53 -0400
Message-ID: <44BE936B.3080107@wetafx.co.nz>
Date: Thu, 20 Jul 2006 08:17:47 +1200
From: Bill Ryder <bryder@wetafx.co.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 Thunderbird/1.5.0.4 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc1]  Make group sorting optional in the 2.6.x
 kernels
References: <44B32888.6050406@wetafx.co.nz> <20060719080213.GA22925@janus>
In-Reply-To: <20060719080213.GA22925@janus>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

I'm aware of the patch. In fact I've spent far too much time researching
the > 16 groups problem as I'm sure so many others have. It's so sad the
nfs designers made that gid list a fixed length array. Anyway ..

There are two reasons we don't use your patch:

* It's not a standard part of the kernel. So we have to always patch.
This can be  painful for our junior admins for new versions.
* The major reason though is that we run OSX and IRIX as well linux. By
using setgroups everywhere we solve our problem for all cases, including
the proprietary OS's for which we don't have source. This is a big deal.


I thought a smaller simpler patch would be easier to get into linux as
standard would be easier to accept - and that in combination with our
userland tools solves our problem. Also the new version of the patch
which I will write will not completely break the semantics of setgroups
which is what the 2.6.x kernel does now.


As an aside Frank - can you point at a paper which provides a
walkthrough of how your patch  works and what the caveats are?

I tried to find a straightforward explanation a while ago and couldn't
-  and didn't have the time to work through it myself. I only have a
pretty sketchy understanding of the flow of control/data for nfs/fs
permissions checking in the kernel and it would take me a LONG time to
figure it out - assuming I even could.

For our purposes we would have a single process which needs to be able
to access multiple groups at completely different points in the tree..

For example

/top(0)/p1(2)/p3(2)/p4(2)/p5(6)/file1(6)
/top(0)/p1(2)/p3(2)/p4(2)/p6(7)/file2(7)
/top(0)/p1(2)/p3(2)/p4(2)/p7(8)/file3(6)
/top(0)/p1(2)/p3(2)/p4(2)/p7(8)/file4(8)

And so on - where the (n) indicated the (gid) for that directory/file.
So most of our directories are in the same group. But as you get further
down the tree the groups start to change.

The process will belong to > 16 groups.


Thanx
Bill


Frank van Maarseveen wrote:
> On Tue, Jul 11, 2006 at 04:26:48PM +1200, Bill Ryder wrote:
>   
>> Hello all,
>>
>> Setting the kernel config option of UNSORTED_SUPPLEMENTAL_GROUPLIST
>> will allow the use of setgroups(2) to reorder a supplemental
>> group list to work around the NFS AUTH_UNIX 16 group limit. 
>>     
>
> FYI,
>
> This problem has been worked around for several years now using
> these 2.4.x and 2.6.x patches:
>
> 	http://www.frankvm.com/nfs-ngroups/
>
>
>   
