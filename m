Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbUD2AN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUD2AN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUD2AN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:13:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9430 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262129AbUD2AN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:13:56 -0400
Message-ID: <409048B7.1000103@pobox.com>
Date: Wed, 28 Apr 2004 20:13:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: brettspamacct@fastclick.com
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <4090467E.4070709@fastclick.com>
In-Reply-To: <4090467E.4070709@fastclick.com>
Content-Type: multipart/mixed;
 boundary="------------050309050708050705000607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050309050708050705000607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Brett E. wrote:
> exits, freeing up the malloc'ed memory. This brings free memory up by 
> 400 megs and brings the cache down to close to 0, of course the cache 

Yeah, I have something similar (attached).  Run it like

	fillmem <number-of-megabytes>


> grows right afterwards. It would be nice to cap the cache datastructures 
> in the kernel but I've been posting about this since September to no 
> avail so my expectations are pretty low.

This is a frequent request...  although I disagree with a hard cap on 
the cache, I think the request (and similar ones) should hopefully 
indicate to the VM gurus that the kernel likes cache better than anon 
VMAs that must be swapped out.

	Jeff



--------------050309050708050705000607
Content-Type: text/plain;
 name="fillmem.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fillmem.c"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define MEGS 140
#define MEG (1024 * 1024)

int main (int argc, char *argv[])
{
	void **data;
	int i, r;
	size_t megs = MEGS;

	if ((argc >= 2) && (atoi(argv[1]) > 0))
		megs = atoi(argv[1]);

	data = malloc (megs * sizeof (void*));
	if (!data) abort();

	memset (data, 0, megs * sizeof (void*));

	srand(time(NULL));

	for (i = 0; i < megs; i++) {
		data[i] = malloc(MEG);
		memset (data[i], i, MEG);
		printf("malloc/memset %03d/%03lu\n", i+1, megs);
	}
	for (i = megs - 1; i >= 0; i--) {
		r = rand() % 200;
		memset (data[i], r, MEG);
		printf("memset #2 %03d/%03lu = %d\n", i+1, megs, r);
	}
	printf("done\n");
	return 0;
}

--------------050309050708050705000607--

