Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUKUD7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUKUD7B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 22:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUKUD7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 22:59:01 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:12742 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261766AbUKUD66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 22:58:58 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Avi Kivity <avi@argo.co.il>
Cc: Hugh Dickins <hugh@veritas.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI? 
In-reply-to: Your message of "Thu, 18 Nov 2004 17:47:14 +0200."
             <419CC402.7080109@argo.co.il> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 21 Nov 2004 14:58:43 +1100
Message-ID: <4157.1101009523@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 17:47:14 +0200, 
Avi Kivity <avi@argo.co.il> wrote:
>Keith Owens wrote:
>
>>So for VLI code, ksymoops splits the code line into two separate pieces
>>and processes each one seperately.  ksymoops prints the first bit with
>>a warning that it may not be reliable.  The second bit, and all the
>>code line for non-VLI architectures, is reliable and is printed without
>>a warning.
>
>ksymoops can disasemble the entire code line, but starting at different 
>offsets (up to the maximum instruction length) from the start. the first 
>disassembly to include the program counter in the output would be deemed 
>correct.

I originally tried that and rejected it, there are far too many false
positives on i386.  It does not matter where you start the disassembly,
it converges to the correct instructions fairly quickly.

Run this test case through ksymoops 2.4.9 or later.  It is the same
Code: line repeated 6 times, stripping one byte off the front of the
code for each repeat.  That has the same effect as your suggestion of
starting at different offsets, without having to write any C code.

EIP:    0010:[<c0113f8c>] VLI
Code: 8b 15 2c e4 09 08 89 e5 83 ec 08 85 d2 75 49 8b 15 28 e4 09 08 8b 02 85 c0 74 1a 8d 74 26 00 <8d> 42 04
EIP:    0010:[<c0113f8c>] VLI
Code: 15 2c e4 09 08 89 e5 83 ec 08 85 d2 75 49 8b 15 28 e4 09 08 8b 02 85 c0 74 1a 8d 74 26 00 <8d> 42 04
EIP:    0010:[<c0113f8c>] VLI
Code: 2c e4 09 08 89 e5 83 ec 08 85 d2 75 49 8b 15 28 e4 09 08 8b 02 85 c0 74 1a 8d 74 26 00 <8d> 42 04
EIP:    0010:[<c0113f8c>] VLI
Code: e4 09 08 89 e5 83 ec 08 85 d2 75 49 8b 15 28 e4 09 08 8b 02 85 c0 74 1a 8d 74 26 00 <8d> 42 04
EIP:    0010:[<c0113f8c>] VLI
Code: 09 08 89 e5 83 ec 08 85 d2 75 49 8b 15 28 e4 09 08 8b 02 85 c0 74 1a 8d 74 26 00 <8d> 42 04
EIP:    0010:[<c0113f8c>] VLI
Code: 08 89 e5 83 ec 08 85 d2 75 49 8b 15 28 e4 09 08 8b 02 85 c0 74 1a 8d 74 26 00 <8d> 42 04

For all six inputs, the disassembler converges to the correct sequence.
The "unreliable" sequences always end with the correct set of
instructions, test, jne, mov, mov, test, je, lea.

There is no way to tell which interpretation is correct, but it does
not matter.  The instructions just before EIP are valid, which is all
that we care about.

