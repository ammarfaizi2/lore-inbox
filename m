Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTKOTtr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 14:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTKOTtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 14:49:47 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:50055 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S261988AbTKOTtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 14:49:46 -0500
Date: Sat, 15 Nov 2003 19:49:43 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: Harald Welte <laforge@netfilter.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <20031115173310.GA4786@obroa-skai.de.gnumonks.org>
Message-ID: <Pine.LNX.4.44.0311151937190.743-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Harald,

The thing to be aware of is that seq API is limited to 1 page of data per
read(2) call. Some people loudly proclaim "seq API is unlimited, unlike
the old /proc formalism which was limited to 1 page" but they are 
quiet about 1-page limitation for a single read(2) (due to hardcoded
kmalloc(size) in seq_file.c). Why is this important? Because if your
->start/stop routines take/drop some spinlocks then you have to know your
position and re-verify it on the next read(2) if your data is more than 1
page and thus could not be read atomically (i.e. while holding the
spinlocks).

The way I do it is by looking at the integer 'offset' parameter passed to 
'start' and walk the linked list to the same 'distance' from the head (if 
there is still anything that far) and verify if I am looking at the "same" 
(in quotes because the concept of "same" has to be defined, not 
with 100% accuracy :) element as it was at the end of the previous page.

The above was the only unpleasant complication with dealing with seq API. 
The rest seemed very smooth and worked as expected. And the ->private 
field of seq_file was very useful to maintain the information per open 
instance of the file, i.e. per 'file' structure. I didn't understand why 
it is not applicable in your case, but maybe I am missing the details of 
your implementation or something like that.

Kind regards
Tigran


