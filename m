Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVCRLA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVCRLA6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 06:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCRLA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 06:00:58 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:3715 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261557AbVCRLAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 06:00:37 -0500
Message-ID: <4239F4E8.8020303@ribosome.natur.cuni.cz>
Date: Thu, 17 Mar 2005 22:21:44 +0100
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b2) Gecko/20050304
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbols in	/lib/modules/2.4.28-pre2/xfree-drm/via_drv.o
References: <42384AB9.1080905@ribosome.natur.cuni.cz> <1110986170.6292.20.camel@laptopd505.fenrus.org> <42384EE8.9000003@ribosome.natur.cuni.cz> <20050316115312.GA12881@logos.cnet>
In-Reply-To: <20050316115312.GA12881@logos.cnet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Wed, Mar 16, 2005 at 04:21:12PM +0100, Martin MOKREJ? wrote:
> 
>>Arjan van de Ven wrote:
>>
>>>On Wed, 2005-03-16 at 16:03 +0100, Martin MOKREJ?? wrote:
>>>
>>>
>>>>Hi,
>>>>does anyone still use 2.4 series kernel? ;)
>>
>>>># make dep; make bzImage; make modules
>>>>[cut]
>>>># make modules_install
>>>>[cut]
>>>>cd /lib/modules/2.4.30-pre3-bk2; \
>>>>mkdir -p pcmcia; \
>>>>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} 
>>>>pcmcia
>>>>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  
>>>>2.4.30-pre3-bk2; fi
>>>>depmod: *** Unresolved symbols in 
>>>>/lib/modules/2.4.28-pre2/xfree-drm/via_drv.o
>>>
>>>
>>>this is not the module shipped by the kernel.org kernel...
>>
>>Right. Sorry that I didn't say it more clearly, but I'm installing 
>>2.4.30-pre3-bk2 kernel.
>>cd /usr/src/linux-2.4.30-pre3-bk2
>>make dep
>>make bzImage
>>make modules
>>make modules_install
>>
>>and then I hit the error about some totally unrelated kernel version in 
>>/lib/modules? :(
> 
> 
> Martin,
> 
> Can you find out why is depmod trying to open /lib/modules/2.4.28-pre2/ ?
> 
> I've got no clue.

Hi all,
  unfortunately I was too fast deleting the problematic /lib/modules/2.4.28-pre2
directory. Here's the log of what I've done at about the time I hit the problem:

  427  cd /usr/src
  428  ls
  429  uname -a
  430  bzip2 -dc linux-2.4.29.tar.bz2 | tar xf -
  431  cd linux-2.4.29
  432  bzip2 -dc ~mmokrejs/tmp/patch-2.4.30-pre3.bz2 | patch -p1
  433  bzip2 -dc ~mmokrejs/tmp/patch-2.4.30-pre3-bk2.bz2 | patch -p1
  434  cp ../linux-2.4.30-pre1-bk5/.config .
  435  cd ..
  436  mv linux-2.4.29 linux-2.4.30-pre3-bk2
  437  pwd
  438  cd linux-2.4.30-pre3-bk2
  439  make oldconfig
  440  make dep; make bzIMage; make modules
  441  make modules_install
  442  make modules_install
  443  ls
  444  make bzImage
  445  make modules
  446  make modules_install
  447  make bzImage
  448  make modules
  449  make modules_install
  450  gzip .config
  451  gzip -d .config.
  452  gzip -d .config.gz 
  453  cp .config .config-ok
  454  make menuconfig
  455  make dep; make bzImage; make modules
  456  make modules_install
  457  make menuconfig
  458  make dep; make bzImage; make modules
  459  make modules_install
  460  make menuconfig
  461  make dep; make bzImage; make modules
  462  make modules_install
  463  make menuconfig
  464  make dep; make bzImage; make modules
  465  make modules_install
  466  rm -rf /lib/modules/2.4.28-pre2
  467  make modules_install


The step 466 "fixed" my problem. I have repeated all the steps as show in the history log,
but no luck to hit the problem again. I just guess the /lib/modules/2.4.28-pre2/xfree-drm/via_drv.o
file came from gentoo's xfree-drm package as at that time /usr/src/linux pointed to that kernel version.
The System.map (/usr/src/linux-2.4.28-pre2/System.map) maybe wasn't updated, as I think the modules
just get compiled against configured kernel src tree.

I did in the /usr/src/linux-2.4.30-pre3-bk2 tree (while rm -rf /lib/modules/2.4.28-pre2 already happened):
strace make modules_install 2>&1 | grep '2.4.28'
and go nothing interresting.

Also, 
find . -type f | xargs grep 2.4.28
doesn't show anything of interrest.


# depmod --version
module-init-tools 3.1

-- 
Martin Mokrejs
Email: 'bW9rcmVqc21Acmlib3NvbWUubmF0dXIuY3VuaS5jeg==\n'.decode('base64')
GPG key is at http://www.natur.cuni.cz/~mmokrejs

