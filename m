Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVFWB2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVFWB2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVFWB2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:28:04 -0400
Received: from web53508.mail.yahoo.com ([206.190.37.69]:24194 "HELO
	web53508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261818AbVFWB1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:27:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=w3b6JMUqCjTgkQIEeVVZdUXfwVTEgfKkrWjd3PEg+tSfJ/QF69DMnPLZjcLSDDWNjW1iJtJIA1r0gyT5MlqUaYLnFcSGDHkaKzBb6qcLxQty3h7s7SdG4SGeGMkVRe8KJX4cGzl/Vq7xPZhrFpe1q/+xt/TMREiZjTfhO1kB/mw=  ;
Message-ID: <20050623012732.64286.qmail@web53508.mail.yahoo.com>
Date: Wed, 22 Jun 2005 18:27:32 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: [W1] Fix slave addition on big-endian platform
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
 In the 2.6.12 code the "rn" structure is in the wrong-endianness when
passed to w1_attach_slave_device(). This causes problems like the
family and crc being swapped around. The following patch fixes the
problem for me.

Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -493,6 +493,7 @@ void w1_slave_found(unsigned long data, 
        struct w1_reg_num *tmp;
        int family_found = 0;
        struct w1_master *dev;
+       u64 rn_le = cpu_to_le64(rn);
 
        dev = w1_search_master(data);
        if (!dev) {
@@ -522,10 +523,8 @@ void w1_slave_found(unsigned long data, 
                slave_count++;
        }
 
-       rn = cpu_to_le64(rn);
-
        if (slave_count == dev->slave_count &&
-               rn && ((le64_to_cpu(rn) >> 56) & 0xff) ==
w1_calc_crc8((u8 *)&rn, 7)) {
+               rn && ((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&rn_le,
7)) {
                w1_attach_slave_device(dev, tmp);
        }
                        



		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 

