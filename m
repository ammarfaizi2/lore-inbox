Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269633AbUJSTAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269633AbUJSTAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbUJSSwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:52:36 -0400
Received: from neopsis.com ([213.239.204.14]:50124 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S269581AbUJSSvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:51:23 -0400
Message-ID: <41756217.8090504@dbservice.com>
Date: Tue, 19 Oct 2004 20:51:03 +0200
From: Tomas Carnecky <tom@dbservice.com>
Organization: none
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: my opinion about VGA devices
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've followed the discussion about the console code restructuring and 
framebuffer devices (Generic VESA framebuffer driver and Video card 
BOOT) and I'd like to present here my opinion.

That's how I think the device drivers should look like:

A graphics device driver consists of two parts, a kernel module and a 
user-space library which are together the 'driver'. Only the user-space 
library knows how to operate the device so there is no access to the 
graphics device from the kernel.
The kernel module creates a character device which can be opened by any 
application with the appropriate rights. The kernel module also 
registeres the device to the kernel so the kernel knows which graphics 
cards are present and their basic information (vendor, name etc.).
Since the kernel has no access to the device, no messages or text can be 
displayed from the kernel, which I think is quite bad during 
startup/boot, that's why the kernel module also provides a function for 
displaying text. However, you don't want the kernel to draw text 
messages to the display while you play doom3 :), that's why this drawing 
can be disabled (by init or somewhere in the early userspace 
initialization).
An application which want's to use the device opens the character device 
and gets the name of the user-space library (user-space driver part) and 
loads it. The library has a set of functions (API) which can be used to 
access the device. BTW, the user-space library API is OpenGL.
How the kernel and user-space driver part communicate is up to them (or 
the programmer). There are no restrictions what to put into user-space 
or kernel-space, may the device driver writer decide this. And there are 
only two interfaces: one in the kernel (text drawing) and one in the 
user-space (OpenGL), nothing between. So the driver can be optimized for 
each specific chip, because each chip is different and is meant to be 
accessed differently.

I don't like the framebuffer devices or even the DRI drivers because:
most applications use a 'high-level' API for rendering (OpenGL). These 
'high-level commands' are translated to 'intermediate commands' 
(framebuffer/DRI ioctl calls etc.) before being send to the card as 
'low-level commands'. Why this intermediate layer?
Even if the high-level and intermediate commands are similar and you 
don't loose much doing the translation (DRI), it is one too much. When 
working with music you try to encode/decode your song as few times as 
possible. because you loose quality each time (and it takes time). The 
same applies to graphics commands, even if you might not loose quality 
(I hope), but it is just unnecessary.

Maybe you have noticed that I haven't used 'VGA' even once, that's 
because I don't think in terms 'VGA device'. I think in terms 'graphics 
device' that's a device which can be used to display 'stuff' on a screen 
and I don't care about how it is done, whether using VGA or the card is 
in 3D mode and is accessed differently (preferably VGA isn't used at all 
for graphics access). The VGA specific problems should be solved on a 
lower level, I have the impression that the VGA peoblems are among the 
biggest in the world when reading this list. By lower level I mean that 
if a driver uses VGA to access the device, it should coordinate with 
other VGA devices using a small block in the kernel but it should not be 
  any major part of the kernel.

I think this would make the suspend/resume/access/switching etc problems 
much easier to solve since the kernel module could tell the library to 
stop drawing/accessing mmap'ed memory etc. (or if the OpenGL rendering 
is done in the kernel module it could just discard the render commands).
Since the user has no direct access to mmap'ed memory and other critical 
sections of the device, the driver can implement proper power managment 
for suspend/resume etc.

Well... that's it.. any comments? I'm sure you have.. :)

-- 
wereHamster a.k.a. Tom Carnecky   Emmen, Switzerland

(GC 3.1) GIT d+ s+: a--- C++ UL++ P L++ E- W++ N++ !o !K  w ?O ?M
           ?V PS PE ?Y PGP t ?5 X R- tv b+ ?DI D+ G++ e-- h! !r !y+
