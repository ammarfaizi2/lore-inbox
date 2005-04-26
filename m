Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVDZU2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVDZU2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVDZU2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:28:43 -0400
Received: from [62.206.217.67] ([62.206.217.67]:65153 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261585AbVDZU2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:28:37 -0400
Message-ID: <426EA471.203@trash.net>
Date: Tue, 26 Apr 2005 22:28:33 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ed Tomlinson <tomlins@cam.org>, Alexander Nyberg <alexn@dsv.su.se>,
       Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: 2.6.12-rc3 spontaneous reboot
References: <200504240008.35435.kernel-stuff@comcast.net> <1114332119.916.1.camel@localhost.localdomain> <200504240903.31377.tomlins@cam.org> <426CADF1.2000100@trash.net> <20050425153541.GC16828@wotan.suse.de> <426E3C6F.6010001@trash.net> <20050426135312.GI5098@wotan.suse.de> <426E48C0.9090503@trash.net> <426E4DD2.8060808@trash.net> <20050426142252.GJ5098@wotan.suse.de>
In-Reply-To: <20050426142252.GJ5098@wotan.suse.de>
Content-Type: multipart/mixed;
 boundary="------------000302030708000809070301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000302030708000809070301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> Ok thanks for the information. I will stare a bit at the patch.
> 
> It is very mysterious though. Even if the patch was somehow wrong
> the worst thing that could happen is that you end up with interrupts
> off when you shouldnt, and the NMI watchdog is very good 
> at catching that.

I found that bringing back the cli in retint_swapgs fixed the problem,
so I traced back paths that could get there with interrupts enabled
and found int_restore_rest -> int_with_check -> retint_swapgs.
Adding a cli to int_restore_rest fixes the problem for me. I hope this
helps.

Regards
Patrick

--------------000302030708000809070301
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

Index: arch/x86_64/kernel/entry.S
===================================================================
--- 585883113da6fe9142de95138c8ed8ca898a4ccc/arch/x86_64/kernel/entry.S  (mode:100644 sha1:3233a15cc4e074c00b75569f21c2844ee280b214)
+++ uncommitted/arch/x86_64/kernel/entry.S  (mode:100644)
@@ -307,6 +307,7 @@
 1:	movl $_TIF_NEED_RESCHED,%edi	
 int_restore_rest:
 	RESTORE_REST
+	cli
 	jmp int_with_check
 	CFI_ENDPROC
 		

--------------000302030708000809070301--
