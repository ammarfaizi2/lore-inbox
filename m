Return-Path: <linux-kernel-owner+w=401wt.eu-S964989AbWLTLCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWLTLCT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWLTLCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:02:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:4169 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbWLTLCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:02:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NFm36KU87RDhJIOe8Zug8HA6OjQC0zk6WvvgKIcMO7cKjjAxyfFyF7exv/iTPJVwr4ElIrYWoJPWw1XBTi3XJ72bWU5hwB1ZeVFV519iuRJrqDTi8apqS1ABdUS3XA1RKkAGM09BmafHNGJIsLb2cNLjh8Pbm+YRXK3FAHOL82Y=
Message-ID: <5157576d0612200302j556694bfsfdc6cb0c37b054c@mail.gmail.com>
Date: Wed, 20 Dec 2006 14:02:15 +0300
From: "Tomasz Kvarsin" <kvarsin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Alexander Viro" <viro@zeniv.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [BUG] garbage instead of zeroes in UFS
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some problems with write support of UFS.
Here is script which demonstrate problem:

#create image
mkdir /tmp/ufs-expirements && cd /tmp/ufs-expirements/
for ((i=0; i<1024*1024*2; ++i)); do printf "z"; done > image

#build ufs tools
wget 'http://heanet.dl.sourceforge.net/sourceforge/ufs-linux/ufs-tools-0.1.tar.bz2'
&& tar xjf ufs-tools-0.1.tar.bz2 && cd ufs-tools-0.1
wget http://lkml.org/lkml/diff/2006/5/20/48/1 -O build.patch
patch -p1 < build.patch && make

#create UFS file system on image
./mkufs -O 1 -b 16384 -f 2048 ../image
cd .. && mkdir root
mount -t ufs image root -o loop,ufstype=44bsd
cd root/
touch a.txt
echo "END" > end.txt
dd if=./end.txt of=./a.txt bs=16384 seek=1

and at the end content of "a.txt" not only  "END" and zeroes,
"a.txt" also contains "z".

The real situation happened when I deleted big file,
and create new one with holes. This script just easy way to reproduce bug.
