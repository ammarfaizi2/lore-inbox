Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWDUQTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWDUQTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWDUQTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:19:32 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:59568
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S932410AbWDUQTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:19:31 -0400
From: =?iso-8859-1?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
To: mikado4vn@gmail.com
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
Date: Fri, 21 Apr 2006 19:18:44 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <4448F9A7.9040803@gmail.com>
In-Reply-To: <4448F9A7.9040803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604211918.45427.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 18:26, Mikado wrote:
> Does your module get into below problem?
>
> http://lkml.org/lkml/2006/4/20/132
Nope.

A short test:
On host:
sudo iptables -A INPUT -p tcp --dport 81 -j DROP
In qemu:
#iptables -t skfilter -A OUTPUT -m fireflier_match --inode-owner 
24392 --dev-owner /dev/root -j LOG --log-prefix test_out2
#netcat 172.20.0.1 81
[4295327.547000] test_out2:IN= OUT=eth0 SRC=172.20.0.10 DST=172.20.0.1 LEN=60 
TOS=0x00 PREC=0x00 TTL=64 ID=11865 DF PROTO=TCP SPT=34945 DPT=81 WINDOW=5840 
RES=0x00 SYN URGP=0
[4295327.549000] test_out2:IN= OUT=eth0 SRC=172.20.0.10 DST=172.20.0.1 LEN=60 
TOS=0x00 PREC=0x00 TTL=64 ID=11865 DF PROTO=TCP SPT=34945 DPT=81 WINDOW=5840 
RES=0x00 SYN URGP=0
[4295330.550000] test_out2:IN= OUT=eth0 SRC=172.20.0.10 DST=172.20.0.1 LEN=60 
TOS=0x00 PREC=0x00 TTL=64 ID=11866 DF PROTO=TCP SPT=34945 DPT=81 WINDOW=5840 
RES=0x00 SYN URGP=0

As you can see several packets are sent out, and each one is matched (24392 is 
the inode of netcat here). 

Please note that using fireflier LSM is not recomended, as I am working on 
writing SELinux policies that do the same (fireflier LSM is itself using code 
from hooks.c from selinux). 
See: http://lkml.org/lkml/2006/4/17/81


Also take a look at James Morris's skfilter patches (which are used in 
fireflier too), they allow you to match at socket level, and also allow to 
match based on selinux context.

Cheers,
Edwin
