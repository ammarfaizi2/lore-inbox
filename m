Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbUK0UsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUK0UsD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 15:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUK0UrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 15:47:08 -0500
Received: from www.zeroc.com ([63.251.146.250]:64746 "EHLO www.zeroc.com")
	by vger.kernel.org with ESMTP id S261323AbUK0Upw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 15:45:52 -0500
Message-ID: <006001c4d4c2$14470880$6400a8c0@centrino>
From: "Bernard Normier" <bernard@zeroc.com>
To: <linux-kernel@vger.kernel.org>
Subject: Concurrent access to /dev/urandom
Date: Sat, 27 Nov 2004 15:45:49 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use /dev/urandom to generate UUIDs by reading 16 random bytes from
/dev/urandom (very much like e2fsprogs' libuuid).

As long as I serialize access to /dev/urandom, I get different values.
However, with concurrent access to /dev/urandom, I quickly get duplicate
values. libuuid uses one shared file descriptor for all threads, while
the test case below uses a file descriptor per read; it does not appear
to change anything ... duplicates appear very quickly (within seconds).
I tried on 2.4.20-27.9smp, 2.6.8-1.521smp, 2.6.9-1.6_FC2smp.

Within one process, I could easily serialize access to /dev/urandom to
avoid this problem. But I suspect the same would happen with concurrent
access from different processes, and I'd rather avoid interprocess
synchronization. Is this the expected behavior of /dev/urandom? Any
suggestions on how to get unique values?

Thanks,
Bernard

#include <pthread.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include <iostream>
#include <set>

using namespace std;

static pthread_mutex_t staticMutex = PTHREAD_MUTEX_INITIALIZER;

struct Key
{
    long long high;
    long long low;
};

struct KeyComp
{
    inline bool operator()(const Key& lhs, const Key& rhs)
    {
 return lhs.high < rhs.high || (lhs.high == rhs.high && lhs.low < rhs.low);
    }
};

static set<Key, KeyComp> keySet;
static int keyCount;


void* threadFailed()
{
    return reinterpret_cast<void*>(-1);
}

extern "C"
void* readRandom(void* d)
{
    int threadId = reinterpret_cast<int>(d);

    for(int i = 0; i < keyCount; ++i)
    {
 int fd = open("/dev/urandom", O_RDONLY);

 if (fd == -1)
 {
     cerr << "could not open /dev/urandom" << endl;
     return threadFailed();
 }

 int reads = 0;
 size_t index = 0;
 char buffer[16];

 while(reads <= 20 && index != sizeof(Key))
 {
     ssize_t bytesRead = read(fd, buffer + index, sizeof(Key) - index);

     if(bytesRead == -1)
     {
  if(errno != EINTR)
  {
      int err = errno;
      cerr << "Reading /dev/urandom returned " << strerror(err) << endl;
      close(fd);
      return threadFailed();
  }
     }
     else
     {
  index += bytesRead;
  reads++;
     }
 }

 if(index != sizeof(buffer))
 {
     close(fd);
     cerr << "Giving up after 20 reads!" << endl;
     return threadFailed();
 }

 close(fd);

 int err = pthread_mutex_lock(&staticMutex);
 if(err != 0)
 {
     cerr << "pthread_mutex_lock failed" << endl;
     return threadFailed();
 }

 Key& key = reinterpret_cast<Key&>(buffer);

 pair<set<Key, KeyComp>::iterator, bool> result = keySet.insert(key);
 if(!result.second)
 {
     cerr << "******** Found duplicate!! **********" << endl;
     struct AsInts
     {
  unsigned int x1;
  unsigned int x2;
  unsigned int x3;
  unsigned int x4;
     };

     AsInts& ints = reinterpret_cast<AsInts&>(buffer);
     cerr << hex << ints.x1 << "-" << ints.x2 << "-" << ints.x3 << "-" << 
ints.x4 << endl;

     pthread_mutex_unlock(&staticMutex);
     return threadFailed();
 }

 if(i > 0 && (i % 100000 == 0))
 {
     cout << "Thread " << threadId << ": read " << i << " keys" << endl;
 }

 err = pthread_mutex_unlock(&staticMutex);
 if(err != 0)
 {
     cerr << "pthread_mutex_unlock failed" << endl;
     return threadFailed();
 }
    }

    return 0;
}

int main(int argc, char* argv[])
{
    if(argc != 3)
    {
 cerr << "Usage: " << argv[0] << " [number of keys to read] [number of 
threads]" << endl;
 return -1;
    }

    int howMany = atoi(argv[1]);
    int threadCount = atoi(argv[2]);
    keyCount = howMany / threadCount;

    pthread_t* threads = new pthread_t[threadCount];

    for(int i = 0; i < threadCount; ++i)
    {
 int err = pthread_create(&threads[i], 0, readRandom, 
reinterpret_cast<void*>(i));
 if(err != 0)
 {
     cerr << "pthread_create failed" << endl;
     return -1;
 }
    }

    for(int i = 0; i < threadCount; ++i)
    {
 void* threadStatus;
 int err = pthread_join(threads[i], &threadStatus);
 if(err != 0)
 {
     cerr << "pthread_join failed" << endl;
     return -1;
 }
 if(threadStatus != 0)
 {
     cerr << "Thread " << i << " failed" << endl;
     return -1;
 }
    }

    delete[] threads;
    return 0;
}

// build with  g++ -D_REENTRANT  -o utest utest.cpp -lpthread



