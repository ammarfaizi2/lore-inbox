Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275092AbSITFgr>; Fri, 20 Sep 2002 01:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275094AbSITFgr>; Fri, 20 Sep 2002 01:36:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:59055 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S275092AbSITFgq>;
	Fri, 20 Sep 2002 01:36:46 -0400
Message-ID: <3D8AB518.218F8503@digeo.com>
Date: Thu, 19 Sep 2002 22:41:44 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [patch] remove page->virtual
References: <3D8AAA58.41BC835F@digeo.com> <20020920050320.GH3530@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 05:41:45.0163 (UTC) FILETIME=[67A691B0:01C26068]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Thu, Sep 19, 2002 at 09:55:52PM -0700, Andrew Morton wrote:
> > set_page_address() and page_address() implementations consume 0.4% and
> > 1.3% of CPU time respectively.   I think that's OK. (Plus the tested code
> > was doing an unneeded lookup in set_page_address(), for debug purposes)
> 
> Looks yummy. I'll take it for a spin tonight on my benchmark-o-matic.
> Clearing some more air in ZONE_NORMAL is always welcome here.

Ta.

> On Thu, Sep 19, 2002 at 09:55:52PM -0700, Andrew Morton wrote:
> > c01884f2 6914     10.5108     .text.lock.dir
> > c01546b3 5847     8.88872     .text.lock.namei
> > c01eb99e 3811     5.79355     .text.lock.dec_and_lock
> > c01515dc 3775     5.73883     link_path_walk
> > c015207c 3567     5.42262     path_lookup
> > c015aba4 3194     4.85558     __d_lookup
> > c01eb690 2814     4.2779      __generic_copy_to_user
> > c01eb950 2562     3.8948      atomic_dec_and_lock
> > c0187580 2473     3.7595      ext2_readdir
> > c0155d3c 2172     3.30192     filldir64
> > c0151114 1786     2.71511     path_release
> > c0145b6a 1753     2.66494     .text.lock.open
> 
> What's going on here? fs stuff is really hurting. At any rate, the
> overhead of the address calculation and hashtable lookup is microscopic
> according to this, and I want space.


c0182f90 5949     14.5552     ext2_readdir

           lock_kernel()         

c014f65c 5790     14.1662     path_lookup            

    Confused.  oprofile claims read_lock(&current->fs->lock) but
    it's surely dcache_lock.

c01e6e80 4275     10.4595     atomic_dec_and_lock     

    dput/iput

c014eba4 2264     5.53924     link_path_walk          
c0158050 1988     4.86397     __d_lookup              
c01426e8 1903     4.656       sys_chdir               
c01e6bc0 1735     4.24496     __generic_copy_to_user  
c015319c 1344     3.28831     filldir64               
c014e6b4 1205     2.94823     path_release            
c0109070 1065     2.6057      system_call             
c014b934 929      2.27295     cp_new_stat64           
c014b380 822      2.01116     generic_fillattr        
c0157250 712      1.74202     dput                    
c014b3fc 622      1.52182     vfs_getattr             
c0157468 556      1.36034     dget_locked
