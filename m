Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbTLaStH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 13:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbTLaStH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 13:49:07 -0500
Received: from gamemakers.de ([217.160.141.117]:30090 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S265227AbTLaSs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 13:48:59 -0500
Message-ID: <3FF31A15.4070307@lambda-computing.de>
Date: Wed, 31 Dec 2003 19:48:53 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@lambda-computing.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: ivern@acm.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: File change notification
References: <3FF2FC85.5070906@lambda-computing.de> <3FF31366.30206@acm.org>
In-Reply-To: <3FF31366.30206@acm.org>
Content-Type: multipart/mixed;
 boundary="------------090601040609090400020701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090601040609090400020701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Javier Fernandez-Ivern wrote:

> Rüdiger Klaehn wrote:
>
>> I have been wondering for some time why there is no decent file 
>> change notification mechanism in linux. Is there some deep 
>> philosophical reason for this, or is it just that nobody has found 
>> the time to implement it? If it is the latter, I am willing to 
>> implement it as long there is a chance to get this accepted into the 
>> mainstream kernel.
>
>
> Well, there's fam.  But AFAIK that's all done in user space, and your 
> approach would be significantly more efficient (as a matter of fact, 
> fam could be modified to use your change device as a first level of 
> notification.)
>
Fam is a user space library that has some nice features such as network 
transparent change notification. It currently uses the dnotify mechanism 
if the underlying kernel supports it, but as I mentioned the dnotify 
mechanism requires an open file handle and works only for single 
directories. If the underlying os does not support dnotify, fam resorts 
to polling for file changes (yuk!).

When I have the basics worked out for the new mechanism, one thing I 
would like to do is to modify the fam library to use it. That would be a 
good way to test it, and it would also immediately benefit the big 
desktop environments which use fam.

> I'll be interested in testing this, or (if you wish) help get it done. 
> I'm a kernel hacking newbie at the moment, but I have tinkered around 
> enough with the VFS to be able to work on this.  Up to you.
>
Any help is appreciated. At the moment I am quite happy about what is 
being logged, but I am not sure how to best expose this to the 
interested user space processes. A device was the easiest way, and so 
that is what I used. Other possibilities would be a file in /proc or 
something completely different. I got the impression that dbus might be 
useful for this, but I have no idea how to use it.

If you want to help me, just apply the patch and see wether it works for 
you. You could also take a look at the code and see if you see something 
completely broken.

best regards and a happy new year,

    Rüdiger

p.s. I attached a small test program. It just reads the contents of the 
/dev/inotify device and prints them in (somewhat) human readable form. 
For example to watch for changes in .txt files I would use inotify_test 
| grep txt. This would print out a line whenever a txt file anywhere on 
a system has been created or changed.

--------------090601040609090400020701
Content-Type: text/x-chdr;
 name="inotify.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="inotify.h"

/*
 * Inode notification for Linux
 *
 * Copyright (C) 2003,2004 Rüdiger Klaehn
 */

#define IN_ACCESS	0x00000001	/* Node accessed */
#define IN_MODIFY	0x00000002	/* Node modified */
#define IN_CREATE	0x00000004	/* Node created */
#define IN_DELETE	0x00000008	/* Node removed */
#define IN_RENAME	0x00000010	/* Node renamed */
#define IN_ATTRIB	0x00000020	/* Node changed attibutes */
#define DNAME_LEN 32

typedef struct
{
	unsigned long event;
	unsigned long file_ino;
	unsigned long src_ino;
	unsigned long dst_ino;
	unsigned char name[DNAME_LEN];
} in_info;

--------------090601040609090400020701
Content-Type: text/x-csrc;
 name="inotify_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inotify_test.c"

#include <stdio.h>
#include "inotify.h"

void geteventname(unsigned long event,char *buffer,int n) 
{
	unsigned long events[6]=
	{
		IN_ACCESS,
		IN_MODIFY,
		IN_CREATE,
		IN_DELETE,
		IN_RENAME,
		IN_ATTRIB
	};
	const char *names[6]=
	{
		"IN_ACCESS",
		"IN_MODIFY",
		"IN_CREATE",
		"IN_DELETE",
		"IN_RENAME",
		"IN_ATTRIB"
	};
	int i;
	strncpy(buffer,"",n);
	for(i=0;i<6;i++)
	{
		if(event&events[i])
		{
			if(strlen(buffer)>0)
				strncat(buffer,"|",n);
			strncat(buffer,names[i],n);
		}
	}
}

int main()
{
	FILE *file;
	in_info info;
	int len;
	char eventname[256];
	file=fopen("/dev/inotify","rb");
	if(!file)
	{
		printf("Error: could not open /dev/inotify!\n");
		return -1;
	}

	while(1)
	{
		len=fread(&info,1,sizeof(info),file);
		if(len==sizeof(info)) {
			info.name[DNAME_LEN-1]=0;
			geteventname(info.event,eventname,255);	
			printf("%s %lu %lu %lu %s\n",
				eventname,
				info.file_ino,
				info.src_ino,
				info.dst_ino,
				info.name);
		}

		usleep(200);
	}
	fclose(file);
}

--------------090601040609090400020701--

