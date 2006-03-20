Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWCTIdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWCTIdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWCTIdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:33:16 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:39037 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932220AbWCTIdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:33:15 -0500
Message-ID: <441E68C6.7030107@fr.ibm.com>
Date: Mon, 20 Mar 2006 09:33:10 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vamsi krishna <vamsi.krishnak@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Idea to create a elf executable from running program [process2executable]
References: <3faf05680603181422y7447fd7duc1032bd0e07b9c68@mail.gmail.com>
In-Reply-To: <3faf05680603181422y7447fd7duc1032bd0e07b9c68@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vamsi krishna wrote:
> Hello All,
> 
> I have been working on an idea of creating an executable from a
> running process image.
> 
> MOTIVATION:
> Process migration among the nodes in distributed computing,
> checkpointing process state.
> 
> BASIS:
> 
> The basis of my idea would be update the existing executable with
> extra PHDRS (Program Headers) with type PT_LOAD and each of these
> headers corresponding the vaddr mapping from /proc/<pid>/maps.
> 
> I have done some basic study of kernels loders code in
> 'fs/binfmt_elf.c' especially code in 'load_elf_binary' function, the
> following is my understanding.
> <------------------------------------------>
> bss=0;
> brk=0;
> foreach (phdr in elf_header){
> 
>    if(phdr->type == PT_LOAD){
>         if( phdr->filesize < phdr->memsize){
>            /* Segment with .bss, so update brk and bss*/
>         }
>        else {
>           /* Just map it*/
>        }
>     }
> /*Update brk bss*/
> }
> <------------------------------------>
> 
> from the above the kernel is updating brk, thus creating the start of
> sbrk(0) only when it sees a  PT_LOAD segment with filesize<memsize. So
> if I create a elf executable with all PT_LOAD segments with out any
> segments with filesize < memsize. The kernel will set brk base i.e
> sbrk(0) to the value phdr->vaddr+phdr->memsize of the last PT_LOAD
> segment its mapping? so do I need to reoder my PT_LOAD segments so
> that the heap goes as the last PT_LOAD segment?

Why don't you let execve() finish its job before modifying the mapping ?

Once execve returns, the segments are mapped and you are free to remap them
however you want and fill them in with a state previously saved on disk.

C.
