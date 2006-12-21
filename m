Return-Path: <linux-kernel-owner+w=401wt.eu-S1422768AbWLUHIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbWLUHIH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWLUHIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:08:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44555 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422768AbWLUHIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:08:06 -0500
Date: Wed, 20 Dec 2006 23:07:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Markus Rechberger <mrechberger@gmail.com>, linux-kernel@vger.kernel.org,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [solved] Yenta Cardbus allocation failure
In-Reply-To: <20061220194003.b0db1844.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612202302240.3576@woody.osdl.org>
References: <d9def9db0612120004r45fa1b1dx270a2e9e5be57246@mail.gmail.com>
 <d9def9db0612181612v657197ees925609243fc1ef65@mail.gmail.com>
 <20061220194003.b0db1844.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Andrew Morton wrote:
> 
> Linus has wondered "how much does Windows use"?  How might we determine
> that?

Google knows everything, and finds, on MS own site no less:

  "Windows 2000 default resources:

   One 4K memory window

   One 2 MB memory window

   Two 256-byte I/O windows"

which is clearly utterly bogus and insufficient. But Microsoft apparently 
realized this, and:

  "Windows XP default resources:

   Because one memory window of 4K and one window of 2 MB are not 
   sufficient for CardBus controllers in many configurations, Windows XP 
   allocates larger memory windows to CardBus controllers where possible. 
   However, resource windows are static (that is, the operating system 
   does not dynamically allocate larger memory windows if new devices 
   appear.) Under Windows XP, CardBus controllers will be assigned the 
   following resources:

   One 4K memory window, as in Windows 2000

   64 MB memory, if that amount of memory is available. If 64 MB is not 
   available the controller will receive 32 MB; if 32 MB is not available, 
   the controller will receive 16 MB; if 16 MB is not available, the 
   bridge will receive 8 MB; and so on down to a minimum assignment of 1 
   MB in configurations where memory is too constrained for the operating 
   system to provide a larger window.

   Two 256-byte I/O windows"

So I think we have our answer. Windows uses one 4k window, and one 64MB 
window. And they are no more dynamic than we are (we _could_ try to do it 
dynamically, but let's face it, it's fairly painful to dynamically expand 
PCI bus resources - you may need to reprogram everything up to the root, 
so it would be absolutely crazy to do that unless you have some serious 
masochistic tendencies).

So let's just increase our default value to 64M too.

		Linus
