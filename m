Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVC3XkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVC3XkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVC3XkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:40:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49845 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262579AbVC3Xji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:39:38 -0500
Date: Wed, 30 Mar 2005 18:38:25 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Paulo Marques <pmarques@grupopie.com>,
       Shankar Unni <shankarunni@netscape.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de, khali@linux-fr.org
Subject: Not a GCC bug (was Re: Big GCC bug!!! [Was: Re: Do not misuse Coverity please])
Message-ID: <20050330233825.GS17420@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl> <OofSaT76.1112169183.7124470.khali@localhost> <d2er4p$qp$1@sea.gmane.org> <424AFA98.9080402@grupopie.com> <aae129062f1e3992c8ec025d5f239be9@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae129062f1e3992c8ec025d5f239be9@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 06:11:43PM -0500, Kyle Moffett wrote:
> On Mar 30, 2005, at 14:14, Paulo Marques wrote:
> >Just a minor nitpick, though: wouldn't it be possible for an
> >application to catch the SIGSEGV and let the code proceed,
> >making invalid the assumption made by gcc?
> 
> Uhh, it's even worse than that.  Have a look at the following code:
> >#include <stdio.h>
> >#include <stdlib.h>
> >#include <string.h>
> >#include <errno.h>
> >#include <sys/types.h>
> >#include <sys/mman.h>
> >
> >struct test {
> >        int code;
> >};
> >int test_check_first(struct test *a) {
> >        int ret;
> >        if (!a) return -1;
> >        ret = a->code;
> >        return ret;
> >}
> >int test_check_last(struct test *a) {
> >        int ret;
> >        ret = a->code;
> >        if (!a) return -1;
> >        return ret;
> >}
> >
> >int main() {
> >        int i;
> >        struct test *nullmem = mmap(NULL, 4096, PROT_READ|PROT_WRITE,
> >                        MAP_ANON|MAP_FIXED|MAP_PRIVATE, -1, 0);
> >        if (nullmem == MAP_FAILED) {
> >                fprintf(stderr,"mmap: %s\n",strerror(errno));
> >                exit(1);
> >        }
> >        for (i = 0; i < 2; i++) {
> >                nullmem[i].code = i;
> >                printf("nullmem[%d].code = %d\n",i,i);
> >                printf("test_check_first(&nullmem[%d]) = %d\n",i,
> >                        test_check_first(&nullmem[i]));
> >                printf("test_check_last(&nullmem[%d]) = %d\n",i,
> >                        test_check_last(&nullmem[i]));
> >        }
> >        munmap(nullmem,4096);
> >        exit(0);
> >}

This testcase violates ISO C99 6.3.2.3:
If a null pointer constant is converted to a pointer type, the resulting
pointer, called a null pointer, is guaranteed to compare unequal to a
pointer to any object or function.

But in the testcase above, there is an object whose pointer compares equal
to the null pointer.  So there is nothing wrong with what GCC does.

	Jakub
