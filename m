Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310924AbSCHP6H>; Fri, 8 Mar 2002 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310926AbSCHP56>; Fri, 8 Mar 2002 10:57:58 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:55457 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S310924AbSCHP5l>;
	Fri, 8 Mar 2002 10:57:41 -0500
Message-ID: <3C88DFC9.8060907@sgi.com>
Date: Fri, 08 Mar 2002 09:59:05 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
CC: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.18-rc4-aa1 XFS oopses caused by cpio
In-Reply-To: <1015580766.20800.3.camel@svetljo.st-peter.stw.uni-erlangen.de> <3C88B612.1070206@sgi.com> <3C88C9A1.5070502@st-peter.stw.uni-erlangen.de> <3C88CB1C.90203@sgi.com>
Content-Type: multipart/mixed;
 boundary="------------040807060906000606030200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040807060906000606030200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Lord wrote:

>>
> Ah, so you ran growfs on the filesystem, thats the key here. It looks 
> like the new code
> does not handle growfs correctly, the structure which is null is not 
> allocated in the
> expansion case. I should have a fix shortly.
>
> Steve

Hi,

Can you try and repeat with this patch, it should apply reasonably 
cleanly to the aa tree.

Steve



--------------040807060906000606030200
Content-Type: text/plain;
 name="growfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="growfs.patch"


===========================================================================
Index: linux/fs/xfs/xfs_alloc.c
===========================================================================

2234a2235,2236
> 		pag->pagb_list = kmem_zalloc(XFS_PAGB_NUM_SLOTS *
> 					sizeof(xfs_perag_busy_t), KM_SLEEP);

===========================================================================
Index: linux/fs/xfs/xfs_mount.c
===========================================================================

151,152c151,153
< 			kmem_free(mp->m_perag[agno].pagb_list,
< 			  sizeof(xfs_perag_busy_t) * XFS_PAGB_NUM_SLOTS);
---
> 			if (mp->m_perag[agno].pagb_list)
> 				kmem_free(mp->m_perag[agno].pagb_list,
> 				  sizeof(xfs_perag_busy_t) * XFS_PAGB_NUM_SLOTS);
877,881d877
< 	for (agno = 0; agno < sbp->sb_agcount; agno++) {
< 		mp->m_perag[agno].pagb_count = 0;
< 		mp->m_perag[agno].pagb_list = kmem_zalloc(XFS_PAGB_NUM_SLOTS *
< 					sizeof(xfs_perag_busy_t), KM_SLEEP);
< 	}
1066,1067c1062,1064
< 		kmem_free(mp->m_perag[agno].pagb_list,
< 		  sizeof(xfs_perag_busy_t) * XFS_PAGB_NUM_SLOTS);
---
> 		if (mp->m_perag[agno].pagb_list)
> 			kmem_free(mp->m_perag[agno].pagb_list,
> 			  sizeof(xfs_perag_busy_t) * XFS_PAGB_NUM_SLOTS);

--------------040807060906000606030200--

