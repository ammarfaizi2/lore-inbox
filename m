Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVJOHE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVJOHE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVJOHE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:04:29 -0400
Received: from web33314.mail.mud.yahoo.com ([68.142.206.129]:34157 "HELO
	web33314.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751106AbVJOHE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:04:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VptwmHKZV+JrP+Bf410/Tkc+y9FXZ6Dcaa71AWbP8N6Ba5oS/gtFM12rXU0ENEoZw7BFkjda19D3xqtJiRmsw0JDoWTPXXBI/2n7OUtD6TI79j7+zSa1whXrKF0Ph75FMyMoEsDVbtP3Mv7h7A51H5NCwOZyKVQoK1dKG8ToRb8=  ;
Message-ID: <20051015070426.56781.qmail@web33314.mail.mud.yahoo.com>
Date: Sat, 15 Oct 2005 00:04:26 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: lock_kernel twice possible ?
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was going thru the NFS v3 code for SMP kernel 2.6.11
to see how an inode gets revalidated. I found that
there is a possibility that there may be an attempt to
do lock_kernel() twice.

Is this possible ? If yes then how this deadlock
condition is/can be avoided.

-lnxluv

Below is the code flow (please see ** for
lock_kernel):

nfs_revalidate_inode
 - __nfs_revalidate_inode
   - ** lock_kernel() **
   - nfs_wait_on_inode
   - Call getattr() (which is nfs3_proc_getattr()) to
     get the attributes from the server and 
     refresh the inode with the new values
   - IF the cached data is invalid for the inode
     - Writeback (If dirty) and sync the 
       inode, call nfs_wb_all
     - nfs_wb_all
       - nfs_sync_inode 
           - call nfs_wait_on_requests to wait for
             the requests associated with the pages
             to get complete
           - nfs_flush_inode
             - nfs_scan_dirty
             - nfs_flush_list
               - nfs_flush_one
                 - nfs_write_rpcsetup
                   - nfs3_proc_write_setup
                     - rpc_init_task
                     - rpc_call_setup
           - nfs_execute_write
             - ** lock_kernel() **
             - rpc_execute
             - ** unlock_kernel() **
   - ** unlock_kernel() **     




		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free.
http://music.yahoo.com/unlimited/
