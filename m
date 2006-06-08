Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWFHHpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWFHHpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWFHHpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:45:04 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:45970 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932560AbWFHHpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:45:03 -0400
Date: Thu, 8 Jun 2006 09:43:56 +0200
From: Voluspa <lista1@comhem.se>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: akpm@osdl.org, arjan@infradead.org, Valdis.Kletnieks@vt.edu,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix
 fastcall
Message-Id: <20060608094356.5c1272cc.lista1@comhem.se>
In-Reply-To: <349562623.17723@ustc.edu.cn>
References: <349406446.10828@ustc.edu.cn>
	<20060604020738.31f43cb0.akpm@osdl.org>
	<1149413103.3109.90.camel@laptopd505.fenrus.org>
	<20060605031720.0017ae5e.lista1@comhem.se>
	<349562623.17723@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006 10:57:28 +0800 Fengguang Wu wrote:
[...]
> Would you test two simple commands by the way?
> 
>         time (find / >/dev/null)
>         (repeat and drop the first result)
> 
>         dd if=/dev/zero of=sparse bs=1M seek=5000 count=1
> 
>         time cp sparse /dev/null
>         (repeat and drop the first result)
> 
> These commands measure the pure cpu(or software) overhead of the
> readahead logics, without ever hitting the physical device. I have
> no 64bit cpu numbers for them yet ;)

The commands don't make sense (I'm in bash)... Also, I refuse to
overwrite /dev/null ;-) I've done a test with "cat" but the first
and second run of it are the same, so it does touch the disk, it seems:

root:sleipner:~# grep setra /etc/rc.d/rc.local
#/sbin/blockdev --setra 2048 /dev/hda
/sbin/blockdev --setra 256 /dev/hda
root:sleipner:~# uname -r
2.6.17-rc5-git10-ar2

root:sleipner:~# time find / >/dev/null

real    3m34.119s
user    0m1.118s
sys     0m5.844s
root:sleipner:~# time find / >/dev/null

real    0m2.949s
user    0m0.691s
sys     0m2.253s
root:sleipner:~# dd if=/dev/zero of=sparse bs=1M seek=5000 count=1
1+0 records in
1+0 records out
root:sleipner:~# time cat sparse >/dev/null

real    0m9.377s
user    0m0.140s
sys     0m8.715s
root:sleipner:~# time cat sparse >/dev/null

real    0m9.593s
user    0m0.138s
sys     0m8.680s
*******************************************************************

root:sleipner:~# grep setra /etc/rc.d/rc.local
/sbin/blockdev --setra 2048 /dev/hda
#/sbin/blockdev --setra 256 /dev/hda
root:sleipner:~# uname -r
2.6.17-rc5-git10-ar2

root:sleipner:~# time find / >/dev/null

real    3m33.037s
user    0m1.112s
sys     0m5.821s
root:sleipner:~# time find / >/dev/null

real    0m2.538s
user    0m0.622s
sys     0m1.911s
root:sleipner:~# dd if=/dev/zero of=sparse bs=1M seek=5000 count=1
1+0 records in
1+0 records out
root:sleipner:~# time cat sparse >/dev/null

real    0m11.279s
user    0m0.163s
sys     0m10.340s
root:sleipner:~# time cat sparse >/dev/null

real    0m11.268s
user    0m0.154s
sys     0m10.412s

Mvh
Mats Johannesson
--
