Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVDDNOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVDDNOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 09:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDDNOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 09:14:21 -0400
Received: from sophia.inria.fr ([138.96.64.20]:57759 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S261164AbVDDNOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 09:14:15 -0400
Message-ID: <42513D9A.80001@yahoo.fr>
Date: Mon, 04 Apr 2005 15:14:02 +0200
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dd hangs with SIGINT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (sophia.inria.fr [138.96.64.20]); Mon, 04 Apr 2005 15:14:03 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With recent linux distributions (using NPTL), I noticed that dd can hang
waiting on a futex when being killed. The problem sould be reproduceable
with the following script :

-------$<-------$<-------$<-------$<-------$<-------$<-------$<--------

#!/bin/sh

echo 'When you only see "dd frozen" in a loop the problem is present'

while : ; do
    dd if=/dev/zero of=/dev/null bs=1000 count=200 &> /dev/null
    echo -n "."
done &

# Don't leave useless dd processes
CHILD=$!
trap "kill $CHILD; killall dd" EXIT

while : ; do
    killall -INT dd &> /dev/null
    usleep 10000
    PIDOF_DD1=$(pidof dd)
    usleep 10000
    PIDOF_DD2=$(pidof dd)
    if [ -n "$PIDOF_DD1" ] && [ "$PIDOF_DD1" = "$PIDOF_DD2" ]; then
        echo "dd frozen"
    else
        echo -n "+"
    fi
done

-------$<-------$<-------$<-------$<-------$<-------$<-------$<--------

I can reproduce it on Fedora Core [1-3] on x86, even with recent kernels
like 2.6.12-rc1-bk3,,but it goes away with LD_ASSUME_KERNEL=2.4. It
seems to exploit a race condition somewhere, so the problem may need
some time (or some load) before triggering.


Hopefully someone can reproduce and look into it.
Kind regards.

-- 
Guillaume

