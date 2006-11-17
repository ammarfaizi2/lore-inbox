Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755695AbWKQLb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbWKQLb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 06:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933531AbWKQLb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 06:31:27 -0500
Received: from web23112.mail.ird.yahoo.com ([217.146.189.52]:46716 "HELO
	web23112.mail.ird.yahoo.com") by vger.kernel.org with SMTP
	id S1755695AbWKQLb0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 06:31:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3EDllOeHbantNNHA5x4njZ1EI95tAp5nGaaEzTdkp0MOd0MjMZS38lhTmxLpIdIbOFzdaub7U49GPoohbmJXlxsfmcmrrQLx0ca2FbXto4qLqKTdYlrzc4RSC3f3hr+RHO5g4wgVqztqqgyrEKKQqis7xQpOB8TQM39xUghLk3c=  ;
Message-ID: <20061117113124.75132.qmail@web23112.mail.ird.yahoo.com>
Date: Fri, 17 Nov 2006 11:31:24 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: vm: weird behaviour when munmapping
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, I'm probably missing something but I don't see what. Please be
nice even if the question is really stupid ;)

I'm looking at mmap.c code and to understand it I decided to implement
a dumb char device that implement its own foo_mmap() method. In this
method it defined its own vma ops:

    static void foo_vma_open(struct vm_area_struct *vma)
    static void foo_vma_close(struct vm_area_struct *vma)

A dumb application mmap the device in order to make foo_mmap() install
the vma ops.

    mmap(NULL, 16384, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

mmap returned 0x2aaae000 for example. Until now, foo_vma_open() and
foo_vma_close() are not called.

Now I want to unmap the first part of the previous mapping to see how
vma ops are called. So I did:

    munmap(0x2aaae000, 1024);

and here's what happen:

    foo_vma_open(vma) is called with:
        vma->vm_start = 0x2aaae000
        vma->vm_end = 0x2aaaf000

    foo_vma_close(vma) is called with:
        vma->vm_start = 0x2aaae000
        vma->vm_end = 0x2aaaf000

However I would have expected:

    foo_vma_open(vma) is called with:
        vma->vm_start = 0x2aaaf000
        vma->vm_end = 0x2aaab2000

    foo_vma_close(vma) is called with:
        vma->vm_start = 0x2aaae000
        vma->vm_end = 0x2aaaf000

Can anybody tell me why I get this behaviour ?

thanks

Francis




	

	
		
___________________________________________________________________________ 
Découvrez une nouvelle façon d'obtenir des réponses à toutes vos questions ! 
Profitez des connaissances, des opinions et des expériences des internautes sur Yahoo! Questions/Réponses 
http://fr.answers.yahoo.com
