Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUD2AEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUD2AEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUD2AEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:04:20 -0400
Received: from mail.fastclick.com ([205.180.85.17]:24040 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S262085AbUD2AEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:04:15 -0400
Message-ID: <4090467E.4070709@fastclick.com>
Date: Wed, 28 Apr 2004 17:04:14 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: brettspamacct@fastclick.com
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com>
In-Reply-To: <409021D3.4060305@fastclick.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett E. wrote:

> Same thing happens on 2.4.18.
> 
> I attached sar, slabinfo and /proc/meminfo data on the 2.6.5 machine.  I 
> reproduce this behavior by simply untarring a 260meg file on a 
> production server, the machine becomes sluggish as it swaps to disk. Is 
> there a way to limit the cache so this machine, which has 1 gigabyte of 
> memory, doesn't dip into swap?
> 
> Thanks,
> 
> Brett
> 

I created a hack which allocates memory causing cache to go down, then 
exits, freeing up the malloc'ed memory. This brings free memory up by 
400 megs and brings the cache down to close to 0, of course the cache 
grows right afterwards. It would be nice to cap the cache datastructures 
in the kernel but I've been posting about this since September to no 
avail so my expectations are pretty low.

Here's the code:

#define ALLOC_SIZE 1024*1024
#define NUM_ALLOC 400

int main() {
     char* ptr;
     int i,j;

     for(i=0;i<NUM_ALLOC;i++) {
         ptr = (void*)malloc(ALLOC_SIZE);
         for(j=0;j<ALLOC_SIZE;j+=512) {
                 ptr[j]=0;
         }
     }

     return 0;
}


...
Maybe I can make it a hack of all hacks and have it parse out "Cached" 
from /proc/meminfo and allocate that many bytes.


