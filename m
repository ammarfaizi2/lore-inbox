Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbUK1U6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbUK1U6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 15:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUK1U6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 15:58:24 -0500
Received: from www.zeroc.com ([63.251.146.250]:17282 "EHLO www.zeroc.com")
	by vger.kernel.org with ESMTP id S261583AbUK1U6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 15:58:12 -0500
Message-ID: <02c001c4d58c$f6476bb0$6400a8c0@centrino>
From: "Bernard Normier" <bernard@zeroc.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
References: <006001c4d4c2$14470880$6400a8c0@centrino> <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr>
Subject: Re: Concurrent access to /dev/urandom
Date: Sun, 28 Nov 2004 15:58:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Rule of thumb: Post the smallest possible code that shows the problem.
>>Will do next time!
>
> That would be great, because it could show that urandom is missing a lock
> somewhere.

Here is a smaller version (102 lines vs 173 before). It's difficult to get 
something very very small since I need to start a few threads.

Bernard

#include <pthread.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <assert.h>
#include <errno.h>

#include <set>
#include <iostream>
using namespace std;

// Each thread will generate keyCount keys
static int threadCount = 3;
static int keyCount = 1000000 / threadCount;

// When not defined, all threads read /dev/urandom concurrently
// #define SERIALIZE_READS 1

struct Key
{
    long long high;
    long long low;

    bool operator<(const Key& rhs) const
    {
        return high < rhs.high || (high == rhs.high && low < rhs.low);
    }
};

static set<Key> keySet;
static pthread_mutex_t keySetMutex = PTHREAD_MUTEX_INITIALIZER;

extern "C" void* readRandom(void*)
{
    for(int i = 0; i < keyCount; ++i)
    {
        int fd = open("/dev/urandom", O_RDONLY);
        assert(fd != -1);

#ifdef SERIALIZE_READS
        int err = pthread_mutex_lock(&keySetMutex);
        assert(err == 0);
#endif
        size_t index = 0;
        char buffer[sizeof(Key)];

        while(index != sizeof(Key))
        {
            ssize_t bytesRead = read(fd, buffer + index, sizeof(Key) - 
index);

            if(bytesRead == -1)
            {
                if(errno != EINTR)
                {
                    close(fd);
                    return reinterpret_cast<void*>(-1);
                }
            }
            else
            {
                index += bytesRead;
            }
        }

        close(fd);

#ifndef SERIALIZE_READS
        int err = pthread_mutex_lock(&keySetMutex);
        assert(err == 0);
#endif
        pair<set<Key>::iterator, bool> result = 
keySet.insert(reinterpret_cast<Key&>(buffer));
        if(!result.second)
        {
            cerr << "Found duplicate!" << endl;
        }
        err = pthread_mutex_unlock(&keySetMutex);
        assert(err == 0);
    }

    return 0;
}

int main(int argc, char* argv[])
{
    pthread_t* threads = new pthread_t[threadCount];
    for(int i = 0; i < threadCount; ++i)
    {
        int err = pthread_create(&threads[i], 0, readRandom, 0);
        assert(err == 0);
    }
    for(int i = 0; i < threadCount; ++i)
    {
        void* threadStatus;
        int err = pthread_join(threads[i], &threadStatus);
        assert(err == 0);
        assert(threadStatus == 0);
    }

    delete[] threads;
    return 0;
}

// build with  g++ -D_REENTRANT  -o utest utest.cpp -lpthread



