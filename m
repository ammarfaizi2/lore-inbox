Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVJPJjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVJPJjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 05:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVJPJjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 05:39:49 -0400
Received: from agp.Stanford.EDU ([171.67.73.10]:65183 "EHLO agp.stanford.edu")
	by vger.kernel.org with ESMTP id S1751315AbVJPJjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 05:39:48 -0400
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200510160936.j9G9aMrb009564@csl.stanford.edu>
Subject: [CHECKER] buffer overflows in net/core/filter.c?
To: linux-kernel@vger.kernel.org
Date: Sun, 16 Oct 2005 02:36:21 -0700 (PDT)
Cc: engler@cs.stanford.edu, jschlst@samba.org, mc@cs.stanford.edu
Reply-To: engler@csl.stanford.edu
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it appears that bad filters in net/core/filter.c can read/write arbitrary
kernel memory.

Given a filter created via:

        struct sock_filter s[2];
        memset(s, 0, sizeof s);


        s[0].code = BPF_LD|BPF_B|BPF_ABS;
        s[0].k    = 0x7fffffffUL;
        s[1].code = BPF_RET;
        s[1].k    = 0xfffffff0UL;

or:

        s[0].code = BPF_LD|BPF_B|BPF_IND;
        s[0].k    = 0x7fffffffUL;
        s[1].code = BPF_RET;
        s[1].k    = 0xfffffff0UL;

or

        s[0].code = BPF_LD|BPF_H|BPF_IND;
        s[0].k    = 0x7ffffffeUL;
        s[1].code = BPF_B|BPF_RET;
        s[1].k    = 0xfffffff0UL;

or

        s[0].code = BPF_LD|BPF_H|BPF_IND;
        s[0].k = 0x7ffffffeUL;
        s[1].code = BPF_B|BPF_RET;
        s[1].k = 0xfffffff0UL;


These pass check filter calls:

	sk_chk_filter(s, 2)

But then blow up severely after calling:

static inline void *skb_header_pointer(const struct sk_buff *skb, int offset,
                                       int len, void *buffer)
{
        int hlen = skb_headlen(skb);


which increments the data pointer:

        if (offset + len <= hlen)
                return skb->data + offset;

but does not check if (offset+len) could overflow.  

Something gross along the lines of:

        if((offset + len) < offset) {
                printf("ERROR: hit overflow!\n");
                return NULL;
        }

seems to fix the problem, but most likely filter.c should do it.

If anyone could confirm or refute these I'd appreciate it.  [We've been
developing a tool to automatically generate test cases by running code
partially symbolically and these were some of first errors it flagged.]

Dawson
