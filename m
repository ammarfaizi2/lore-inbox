Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130237AbQLTVMG>; Wed, 20 Dec 2000 16:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbQLTVL5>; Wed, 20 Dec 2000 16:11:57 -0500
Received: from pD9040D12.dip.t-dialin.net ([217.4.13.18]:8714 "HELO
	grumbeer.hjb.de") by vger.kernel.org with SMTP id <S130237AbQLTVLm>;
	Wed, 20 Dec 2000 16:11:42 -0500
Subject: Re: 2.2.18: Thread problem with smbfs
To: urban@teststation.com (Urban Widmark)
Date: Wed, 20 Dec 2000 21:41:51 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012191057010.8007-100000@cola.svenskatest.se> from "Urban Widmark" at Dec 19, 2000 11:58:10 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001220204151.E4FAE3479B1@grumbeer.hjb.de>
From: hjb@pro-linux.de (Hans-Joachim Baader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Urban Widmark wrote:

> I don't really know how signal delivery works within the kernel, but
> smb_trans2_request tries to disable some signals. That does not work
> (completely?) so either it needs fixing or the -512 errno needs to be
> handled.
> 
> Why so bad in gdb? perhaps it causes more signals.
> Why does one thread end up in D state? don't know.
> 
> 
> > Kernel 2.2.18, smbfs as a module. I can provide more info if necessary.
> 
> A small testprogram that causes this would be nice. The -512 is easy to
> reproduce but I haven't seen the 'D' before.
> 
> If someone is interested the relevant code is fs/smbfs/sock.c
> (smb_trans2_request, ..., _recvfrom)

Here is a test program to reproduce this. Don't worry about
missing error checks and so on, it's just a quick hack.
Create the required files file1..file5 on a SMB share and edit
the #define accordingly. File sizes of 1-2 MB should suffice.
Then run the program. It should copy the files to the current
directory. Then run it under gdb. It should hang until you kill
gdb.

I tested only with a NT 4 server (sp 5 or 6).

Regards,
hjb

#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

/* Size of the blocks we read from a file. */
static const int ChunkSize = 8192;

/* Path on the mounted SMB share from which we copy files */
#define SourcePath "/mnt/net/test"

struct CopyThreadInfo
{
    char*        src;
    char*        dst;
};

/* returns 1 on success */
int CopyFile(char* src, char* dst)
{
    char        buffer[ChunkSize];
    int         f, g;
    ssize_t     nRet;
    int         nError;

    if ((f = open(src, O_RDONLY)) < 0)
        return 0;

    g = open(dst, O_WRONLY | O_CREAT | O_TRUNC, 0666);
    if (g < 0)
    {
        close(f);
        return 0;
    }

    do
    {
        nRet = read(f, buffer, sizeof(buffer));
        if (nRet < 0 && errno == EINTR)
            nRet = 0;
        if (nRet < 0)
        {
            return 0;
        }
        if (nRet > 0)
            nRet = write(g, buffer, nRet);
    } while (nRet > 0);

    close(g);
    close(f);

    if (nRet < 0)
        return 0;

    return 1;
}

void* Copy(struct CopyThreadInfo *info)
{
    CopyFile(info->src, info->dst);
    return NULL;
}

void Fetch(char* name)
{
    char src[4096];
    char dst[4096];

    pthread_attr_t attr;
    pthread_t pid;
    struct CopyThreadInfo* pCopy = (struct CopyThreadInfo *) malloc(sizeof(struct CopyThreadInfo));

    strcpy(src, SourcePath);
    strcat(src, name);
    strcpy(dst, name);

    pCopy->src = strdup(src);
    pCopy->dst = strdup(dst);

    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
    pthread_create(&pid, &attr, Copy, pCopy);
}

int main()
{
	Fetch("file1");
	Fetch("file2");
	Fetch("file3");
	Fetch("file4");
	Fetch("file5");
	while(1)
		;
	return 0;
}


-- 
http://www.pro-linux.de/ - Germany's largest volunteer Linux support site
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
