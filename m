Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUCALKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUCALKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:10:31 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:11750 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261204AbUCALK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:10:28 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16451.6690.614292.510000@laputa.namesys.com>
Date: Mon, 1 Mar 2004 14:10:26 +0300
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
In-Reply-To: <Pine.LNX.4.44.0402271544520.1747-100000@chimarrao.boston.redhat.com>
References: <20040227122936.4c1be1fd.akpm@osdl.org>
	<Pine.LNX.4.44.0402271544520.1747-100000@chimarrao.boston.redhat.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:

[...]

 > 
 > Duh, I forgot all about the rotate_reclaimable_page() stuff.
 > That may well fix all problems 2.6 would have otherwise had
 > in this area.
 > 
 > I really hope we won't need anything like the O(1) VM stuff
 > in 2.6, since that would leave me more time to work on other
 > cool stuff (like resource management ;)).

Page-out from end of the inactive list is not efficient, because pages
are submitted for IO in more or less random order and this results in
a lot of seeks. Test-case: replace ->writepage() with

int foofs_writepage(struct page *page)
{
        SetPageDirty(page);
        unlock_page(page);
        return 0;
}

and run

$ time cp /tmpfs/huge-data-set /foofs

File systems (and anonymous memory) want clustered write-out and VM
designs with separate write-out queue (like O(1) VM) are better suited
for this.

Nikita.
