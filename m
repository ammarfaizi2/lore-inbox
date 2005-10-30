Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVJ3Qcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVJ3Qcg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 11:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVJ3Qcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 11:32:36 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:33296 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932175AbVJ3Qcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 11:32:35 -0500
To: Andi Kleen <ak@suse.de>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [PATCH] x86_64: Work around Re: 2.6.14-git1 (and -git2) build
 failure on AMD64
X-Message-Flag: Warning: May contain useful information
References: <16080000.1130681008@[10.10.2.4]> <200510301649.42064.ak@suse.de>
	<52br17nfmk.fsf@cisco.com> <200510301723.31561.ak@suse.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Sun, 30 Oct 2005 08:32:28 -0800
In-Reply-To: <200510301723.31561.ak@suse.de> (Andi Kleen's message of "Sun,
 30 Oct 2005 17:23:31 +0100")
Message-ID: <523bmjnexv.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 30 Oct 2005 16:32:29.0448 (UTC) FILETIME=[851FA880:01C5DD6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> While not correct I don't see how it should guarantee it
    Andi> will work around that gcc bug on all possible gcc versions
    Andi> (which show different behaviour) My patch is more
    Andi> conservative and safer.

What's the gcc bug?  The current fixup.c code is asking gcc to put
toshiba_ohci1394_dmi_table[] in the .init.text section.  This makes
gcc think that .init.text contains writable data.  Then some other
declaration in the file asks gcc to put a function in .init.text.  gcc
correctly complains that text and writable data can't share a section.

If we fix toshiba_ohci1394_dmi_table[] to go into .init.data as is
intended, then gcc is happy.

The only thing remotely like a gcc bug is that the diagnostic gcc
prints does not flag toshiba_ohci1394_dmi_table[] as the problem.

Admittedly I have only tested gcc 4.0 and gcc 3.4, but given that no
one reported this problem before toshiba_ohci1394_dmi_table[] was
added, and that the __devinit declaration of an array is obviously
wrong and would cause exactly this sort of section conflict, I think
we should at least try the correct fix.

 - R.
