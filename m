Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSGARrO>; Mon, 1 Jul 2002 13:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSGARrN>; Mon, 1 Jul 2002 13:47:13 -0400
Received: from codepoet.org ([166.70.99.138]:46739 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315988AbSGARqq>;
	Mon, 1 Jul 2002 13:46:46 -0400
Date: Mon, 1 Jul 2002 11:49:13 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Timo Benk <t_benk@web.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: allocate memory in userspace
Message-ID: <20020701174913.GA19338@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Timo Benk <t_benk@web.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020701172659.GA4431@toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020701172659.GA4431@toshiba>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 01, 2002 at 07:26:59PM +0200, Timo Benk wrote:
> Hi,
> 
> I am a kernel newbie and i am writing a module. I 
> need to allocate some memory in userspace because
> i want to access syscalls like open(), lstat() etc.
> I need to call these methods in the kernel, and in
> my special case there is no other way, but i 
> do not want to reimplement all the syscalls.

So use the C library and call malloc()

> I read that it should be possible, but i cannot
> find any example or recipe on how to do it.
> It should work with do_mmap() and fd=-1 and
> MAP_ANON, but i jusst can't get it to work.

void *malloc(size_t size)
{
    void *result;
    if (size == 0)
	return NULL;
    result = mmap((void *) 0, size + sizeof(size_t), PROT_READ | PROT_WRITE, 
	    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
    if (result == MAP_FAILED)
	return 0;
    * (size_t *) result = size;
    return(result + sizeof(size_t));
}

void * calloc(size_t nelem, size_t size)
{
    void *result;
    result = malloc(size * nelem);
    if (result)
	memset(result, 0, nelem * size);
    return result;
}

void *realloc(void *ptr, size_t size)
{
    void *newptr = NULL;
    if (size > 0) {
	newptr = malloc(size);
	if (newptr && ptr) {
	    memcpy(newptr, ptr, * ((size_t *) (ptr - sizeof(size_t))));
	    free(ptr);
	}
    }
    else {
	free(ptr);
    }
    return newptr;
}

void free(void *ptr)
{
    if (ptr) {
	ptr -= sizeof(size_t);
	munmap(ptr, * (size_t *) ptr);
    }
}


 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
