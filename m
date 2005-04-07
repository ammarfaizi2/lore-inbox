Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVDGPjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVDGPjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVDGPjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:39:04 -0400
Received: from unthought.net ([212.97.129.88]:24963 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262495AbVDGPit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:38:49 -0400
Date: Thu, 7 Apr 2005 17:38:48 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg Banks <gnb@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050407153848.GN347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
References: <20050406160123.GH347@unthought.net> <20050406231906.GA4473@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050406231906.GA4473@sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 09:19:06AM +1000, Greg Banks wrote:
...
> How large is the client's RAM? 

2GB - (32 bit kernel because it's dual PIII, so I use highmem)

A few more details:

With standard VM settings, the client will be laggy during the copy, but
it will also have a load average around 10 (!)   And really, the only
thing I do with it is one single 'cp' operation.  The CPU hogs are
pdflush, rpciod/0 and rpciod/1.

I tweaked the VM a bit, put the following in /etc/sysctl.conf:
 vm.dirty_writeback_centisecs=100
 vm.dirty_expire_centisecs=200

The defaults are 500 and 3000 respectively...

This improved things a lot; the client is now "almost not very laggy",
and load stays in the saner 1-2 range.

Still, system CPU utilization is very high (still from rpciod and
pdflush - more rpciod and less pdflush though), and the file copying
performance over NFS is roughly half of what I get locally on the server
(8G file copy with 16MB/sec over NFS versus 32 MB/sec locally).

(I run with plenty of knfsd threads on the server, and generally the
server is not very loaded when the client is pounding it as much as it
can)

> What does the following command report
> before and during the write?
> 
> egrep 'nfs_page|nfs_write_data' /proc/slabinfo

During the copy I typically see:

nfs_write_data  681   952 480  8 1 : tunables  54 27 8 : slabdata 119 119 108
nfs_page      15639 18300  64 61 1 : tunables 120 60 8 : slabdata 300 300 180

The "18300" above typically goes from 12000 to 25000...

After the copy I see:

nfs_write_data  36  48 480  8 1 : tunables   54   27 8 : slabdata  5  6  0
nfs_page         1  61  64 61 1 : tunables  120   60 8 : slabdata  1  1  0

-- 

 / jakob

