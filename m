Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTEMUjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbTEMUjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:39:44 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:62728 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261178AbTEMUjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:39:42 -0400
Message-ID: <3EC15C6D.1040403@kolumbus.fi>
Date: Tue, 13 May 2003 23:58:21 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
References: <154080000.1052858685@baldur.austin.ibm.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 13.05.2003 23:53:30,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 13.05.2003 23:53:07,
	Serialize complete at 13.05.2003 23:53:07
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't that what inode->i_sem is supposed to protect...?

--Mika


Dave McCracken wrote:

>As part of chasing the BUG() we've been seeing in objrmap I took a good
>look at vmtruncate().  I believe I've identified a race condition that no
>only  triggers that BUG(), but also could cause some strange behavior
>without the objrmap patch.
>
>Basically vmtruncate() does the following steps:  first, it unmaps the
>truncated pages from all page tables using zap_page_range().  Then it
>removes those pages from the page cache using truncate_inode_pages().
>These steps are done without any lock that I can find, so it's possible for
>another task to get in between the unmap and the remove, and remap one or
>more pages back into its page tables.
>
>The result of this is a page that has been disconnected from the file but
>is mapped in a task's address space as if it were still part of that file.
>Any further modifications to this page will be lost.
>
>I can easily detect this condition by adding a bugcheck for page_mapped()
>in truncate_complete_page(), then running Andrew's bash-shared-mapping test
>case.
>
>Please feel free to poke holes in my analysis.  I'm not at all sure I
>haven't missed some subtlety here.
>
>Dave McCracken
>
>======================================================================
>Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
>dmccr@us.ibm.com                                        T/L   678-3059
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


