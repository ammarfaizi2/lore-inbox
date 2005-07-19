Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVGSK5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVGSK5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 06:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVGSK5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 06:57:05 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:17538 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261956AbVGSK5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 06:57:04 -0400
Message-ID: <42DCDBB2.6070106@gmail.com>
Date: Tue, 19 Jul 2005 12:53:38 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: linux-kernel@vger.kernel.org, rth@twiddle.net, dhowells@redhat.com,
       kumar.gala@freescale.com, davem@davemloft.net, mhw@wittsend.com,
       support@comtrol.com, nils@kernelconcepts.de, chirag.kantharia@hp.com,
       Lionel.Bouton@inet6.fr, benh@kernel.crashing.org,
       mchehab@brturbo.com.br, laredo@gnu.org, rbultje@ronald.bitfreak.net,
       middelin@polyware.nl, philb@gnu.org, tim@cyberelk.net,
       campbell@torque.net, andrea@suse.de, mulix@mulix.org
Subject: Re: [PATCH] pci_find_device --> pci_get_device
References: <42DC4873.2080807@gmail.com> <20050719043621.GA14657@bitwizard.nl>
In-Reply-To: <20050719043621.GA14657@bitwizard.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff napsal(a):

>On Tue, Jul 19, 2005 at 02:25:23AM +0200, Jiri Slaby wrote:
>  
>
>>The patch is for mixed files from all over the tree.
>>
>>Kernel version: 2.6.13-rc3-git4
>>
>>* This patch removes from kernel tree pci_find_device and changes
>>it with pci_get_device. Next, it adds pci_dev_put, to decrease reference
>>count of the variable.
>>* Next, there are some (about 10 or so) gcc warning problems (i. e.
>>variable may be unitialized) solutions, which were around code with old
>>pci_find_device.
>>* Some code was unpretty, or ugly, so the patch provides more readable
>>code, in some cases.
>>* Marks the function as deprecated in pci.h
>>    
>>
>
>Hi Jiri, 
>  
>
Hello,

>The patch grabs reference counts to pdev structures, but almost never
>decreases the reference counts. 
>  
>
I think, that if there is a loop, the pci_get_device always decrease it, see
pci_get_subsys, line 249 (2.6.13-rc3-git4). This function is called by
pci_get_device.
So the question is, if I really need to decrease count, if it occurs in
while (pdev = pci_get_device(..., pdev))
{
initialize(pdev);
// pci_dev_put(pdev); // uncomment or no?
}

Now one problem came on my mind with initialize(pdev) -- if there is
some global var my = pdev in that and it returns back and calls
pci_get_device, it counts down the reference count of pdev, but we need
it anywhere else. Shouldn't be there pci_dev_get to increase ref count and
decrease it either after it is unused or after module unloads or never in
other cases?

>If you are working in a team, and want others to be able to continue
>where you left off, you should add a comment, even if it is repetitive
>to state what needs to be done. 
>  
>
I don't know, if you think it global, or if am I here with other fellows 
(no, I'm not).
I don't know what kind of comment you have on your mind. Could you, please,
specify it more.
I only changed names of called functions and added some pci_dev_put, 
what should
I comment?

>As far as I can see, you grab a reference to the "pdev" on 
>initialization, and never release it. Or you only release it in 
>certain error conditions. Would this make the driver unable to 
>be unloaded and reloaded? That would not be good. 
>  
>
The only thing, that pci_dev_put do, is that it releases memory of pdev 
structure, if
reference count is 0 (as far as I can see, there is no real doc, which 
could ensure me,
it is my piece of knowledge found out from source code, maybe wrong??). 
It does not
do anything with the device.
So, the question is the same as above... Is it right to NOT release, 
when it's in a loop?

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

