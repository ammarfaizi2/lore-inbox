Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUFXWo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUFXWo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbUFXWnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:43:33 -0400
Received: from holomorphy.com ([207.189.100.168]:19597 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265806AbUFXWk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:40:26 -0400
Date: Thu, 24 Jun 2004 15:40:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de, ak@muc.de,
       tripperda@nvidia.com, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624224002.GQ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de, ak@muc.de,
	tripperda@nvidia.com, discuss@x86-64.org,
	linux-kernel@vger.kernel.org
References: <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624222150.GZ30687@dualathlon.random> <20040624223750.GP21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624223750.GP21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/*
On Thu, Jun 24, 2004 at 03:37:50PM -0700, William Lee Irwin III wrote:
> Have you tried with 2.6.7? The following program fails to trigger anything
> like what you've mentioned, though granted it was a 512MB allocation on
> a 1GB machine. swapoff(2) merely fails.

And after fixing a bug in the program, not even that fails:
*/


#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <strings.h>
#include <sys/swap.h>

int main(int argc, char * const argv[])
{
	int i;
	long pagesize, physpages;
	size_t size;
	void *p;

	pagesize = sysconf(_SC_PAGE_SIZE);
	if (pagesize < 0) {
		perror("failed to determine pagesize");
		exit(EXIT_FAILURE);
	}
	physpages = sysconf(_SC_PHYS_PAGES);
	if (physpages < 0) {
		perror("failed to determine physical memory capacity");
		exit(EXIT_FAILURE);
	}
	if ((size_t)(physpages/2) > SIZE_MAX/pagesize) {
		fprintf(stderr, "insufficient virtualspace capacity\n");
		exit(EXIT_FAILURE);
	}
	size = (physpages/2)*pagesize;
	p = malloc(size);
	if (!p) {
		perror("allocation failure");
		exit(EXIT_FAILURE);
	}
	bzero(p, size);
	for (i = 1; i < argc; ++i) {
		if (swapoff(argv[i])) {
			perror("swapoff failure");
			fprintf(stderr, "failed to offline %s\n", argv[i]);
			exit(EXIT_FAILURE);
		}
	}
	return EXIT_SUCCESS;
}
