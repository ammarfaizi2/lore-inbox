Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVAXA2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVAXA2O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVAXA2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:28:14 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:47887 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261388AbVAXA2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:28:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=TDKeM/FZ+sUOIUmpv0xPl42qzSYOU4uszjJLsQ7jTbR+DW7eOO4RXpKnOpPGysWMbwQ6xep5rqFaPo3oGkmTQbwqAS9ygBcfc1z7ua9n9n2KFVdwUy3CDM423yzvrg9JNiqT+P8+1jIDj3ME+AjzBr/lUJ/E1WBZsAUvgs5s95c=
Message-ID: <aa4c40ff0501231628113e492@mail.gmail.com>
Date: Sun, 23 Jan 2005 16:28:09 -0800
From: James Lamanna <jlamanna@gmail.com>
Reply-To: James Lamanna <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/13] Qsort
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sunday, January 23, 2005, Rafael J. Wysocki wrote:
> > On Sunday, 23 of January 2005 06:05, Jesper Juhl wrote:
> > > On Sun, 23 Jan 2005, Andi Kleen wrote:
> > Even with large data sets that are mostly unsorted shell sorts performance 
> > is close to qsort, and there's an optimization that gives it O(n^(3/2)) 
> > runtime (IIRC),
>
> Yes, there is.

After doing a small amount of research into this, according to the abstract at
http://www.cs.princeton.edu/~rs/shell/paperF.pdf you can get O(n^(4/3)) 
with different increment sequences. (1, 8, 23, 77, 281 ...)

So I guess the sort function could look something like this for XFS use
(for reference only!):

void shellsort(void *array, size_t total_elems, size_t size, 
    int (*cmp)(const void *, const void *))
{
    size_t i, j;
    int k, h;
    register char *a = array;  
    const int incs[3] = {23, 8, 1};
    
    for (k = 0; k < 3; k++) {
        for (h = incs[k], i = h; i < total_elems; i++) {
            j = i;
            while (j >= h && cmp(a + (j-h) * size, a + j * size) > 0) {
                swap(a + j * size, a + (j-h) * size);
                j -= h;
            }
        }
    }
}

-- James Lamanna
