Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275402AbTHIU1c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275401AbTHIU1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:27:31 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:44293 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S275400AbTHIU13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:27:29 -0400
Message-ID: <3F355AB0.6@kolumbus.fi>
Date: Sat, 09 Aug 2003 23:33:52 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: cryptoapi incorrect struct page usage
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 09.08.2003 23:28:57,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 09.08.2003 23:28:19,
	Serialize complete at 09.08.2003 23:28:19
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that cryptoapi usage wrt mm is not safe. At least both ipsec 
and cryptoloop practise these kinds of things :

example from net/xfrm/xfrm_algo.c

int
skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, 
int len)
{
    int start = skb_headlen(skb);
    int i, copy = start - offset;
    int elt = 0;

    if (copy > 0) {
        if (copy > len)
            copy = len;
        sg[elt].page = virt_to_page(skb->data + offset);
        sg[elt].offset = (unsigned long)(skb->data + offset) % PAGE_SIZE;
        sg[elt].length = copy;



so unpinned pages are passed to cryptoapi. Nothing prevents these pages 
from being swapped out. Something like get_user_pages() is needed to pin 
these pages for the duration of crypto operations. Comments?

--Mika


