Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVG2VSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVG2VSD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVG2VPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:15:42 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:22547 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262654AbVG2VPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:15:02 -0400
Message-ID: <42EA9C38.90905@stud.feec.vutbr.cz>
Date: Fri, 29 Jul 2005 23:14:32 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH] swsusp: simpler calculation of number of pages
 in PBE list
References: <42EA87A0.908@stud.feec.vutbr.cz> <200507292243.28276.rjw@sisk.pl>
In-Reply-To: <200507292243.28276.rjw@sisk.pl>
Content-Type: multipart/mixed;
 boundary="------------060408070000030101030503"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408070000030101030503
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:
> On Friday, 29 of July 2005 21:46, Michal Schmidt wrote:
> 
>>The function calc_nr uses an iterative algorithm to calculate the number 
>>of pages needed for the image and the pagedir. Exactly the same result 
>>can be obtained with a one-line expression.
> 
> 
> Could you please post the proof?
> 
> Rafael

OK, attached is a proof-by-brute-force program. It compares the results 
of the original function and the simplified one.

This is its output:

$ ./calc_nr2
checked 0 ...
checked 100000000 ...
checked 200000000 ...
checked 300000000 ...
checked 400000000 ...
checked 500000000 ...
checked 600000000 ...
checked 700000000 ...
checked 800000000 ...
checked 900000000 ...
checked 1000000000 ...
checked 1100000000 ...
checked 1200000000 ...
checked 1300000000 ...
checked 1400000000 ...
checked 1500000000 ...
checked 1600000000 ...
checked 1700000000 ...
checked 1800000000 ...
checked 1900000000 ...
checked 2000000000 ...
checked 2100000000 ...
First difference at 2130706433:  -2147483646 x -2147483647

It means that the two functions give the same results for sensible 
values of the input argument.
They results only differ when they overflow into negative values. At 
this point both of the results are useless.

Michal

--------------060408070000030101030503
Content-Type: text/x-csrc;
 name="calc_nr2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="calc_nr2.c"

#include <stdio.h>
#include <limits.h>

typedef struct {
	unsigned long val;
} swp_entry_t;

typedef struct pbe {
	unsigned long address;
	unsigned long orig_address;
	swp_entry_t swap_address;
	struct pbe *next;
} suspend_pagedir_t;

#define PAGE_SIZE 4096
#define PBES_PER_PAGE (PAGE_SIZE/sizeof(struct pbe))

static int calc_nr_orig(int nr_copy)
{
        int extra = 0;
	int mod = !!(nr_copy % PBES_PER_PAGE);
	int diff = (nr_copy / PBES_PER_PAGE) + mod;

	do {
		extra += diff;
		nr_copy += diff;
		mod = !!(nr_copy % PBES_PER_PAGE);
		diff = (nr_copy / PBES_PER_PAGE) + mod - extra;
	} while (diff > 0);
	
	return nr_copy;
}

static int calc_nr(int nr_copy)
{
	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
}

int main()
{
	int i;
	for (i=0; i>=0; i++) {
		if (i%100000000 == 0)
			printf("checked %d ...\n", i);
		if (calc_nr(i) != calc_nr_orig(i)) {
			printf("First difference at %d:  %d x %d\n", i, calc_nr(i), calc_nr_orig(i));
			break;
		}
	}
	return 0;
}


--------------060408070000030101030503--
