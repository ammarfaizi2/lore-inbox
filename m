Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUHRUnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUHRUnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUHRUm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:42:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27556 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267447AbUHRUmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:42:24 -0400
Date: Wed, 18 Aug 2004 16:42:13 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: random ioctls - are they supposed to be like this?
Message-ID: <20040818204213.GA19909@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/random.h has:

#define RNDADDENTROPY   _IOW( 'R', 0x03, int [2] )
#define RNDGETPOOL      _IOR( 'R', 0x02, int [2] )

However, these seem to be used differently in practice.
For example, the one user of RNDADDENTROPY I find does:

struct {
	int ent_count;
	int size;
	unsigned char data[size];
} entropy;

if (ioctl(fd, RNDADDENTROPY, &entropy) != 0) {
...

And, looking at the random driver, it does appear to expect
this format.

Now, RNDGETPOOL in the kernel does:

if (get_user(size, p) ||
    put_user(random_state->poolinfo.poolwords, p++))
	return -EFAULT;
...
if (!copy_to_user(p, tmp, size * sizeof(__u32))) {
...
if(put_user(ent_count, p++))
	return -EFAULT;

Which obviously isn't going to work right if you
just pass in a two-int structure.

Am I reading this wrong, or are callers just supposed
to know to use the other interface?

Bill
