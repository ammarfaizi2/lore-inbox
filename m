Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbUEJWnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUEJWnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUEJWnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:43:06 -0400
Received: from austin.greshamstorage.com ([216.143.252.250]:45828 "EHLO
	austin.greshamstorage.com") by vger.kernel.org with ESMTP
	id S262424AbUEJWmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:42:32 -0400
Message-ID: <40A0042C.6000603@greshamstorage.com>
Date: Mon, 10 May 2004 17:37:32 -0500
From: "Jonathan A. George" <JAGeorge@greshamstorage.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Help? 2.4 to 2.6 pthread problem with popen in gdb
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a work around for the wait4 failure in gdb when debugging a 
program that uses popen from within a pthread?

The behavior is:
correct 2.4
correct 2.4 in gdb 6.x
correct 2.6
failure 2.6 gdb 6.x

Even the most trivial program which uses popen from within a pthread 
will fail immediately, but ONLY under 2.6 and ONLY gdb.   This problem 
has manifested from 2.6.0 - 2.6.6 in the vanilla mainline kernels using 
the current libc/pthread/gdb/gcc from Debian Sid tested with each tool 
or kernel update.

--Jonathan--

P.S. Example code below compiles with g++ filename.cpp -lpthread

#include <iostream>
using namespace std;
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
void *
thread_start( void *thread_arg )
{
    cout << "arg=" << (long) thread_arg << endl;
    FILE *popen_file = popen( "ping -c3 127.0.0.1", "r" );
    cout << "errno=" << errno << endl;
    if( popen_file )
    {
        char linebuf[ 0xff ];
        char *fgets_result = NULL;
        while( NULL != (fgets_result =
            fgets( linebuf, sizeof( linebuf ), popen_file )) )
        {
            cout << "fgets_result=" << fgets_result;//<< endl;
        }
        int pclose_result = pclose( popen_file );
        cout << "pclose_result=" << pclose_result << endl;
    }
    return( NULL );
}

int
main()
{
    cout <<  "hello world" << endl;
    pthread_t tid = 0;
    pthread_attr_t pattr;
    pthread_attr_init( &pattr );
    pthread_attr_setdetachstate(
         &pattr, PTHREAD_CREATE_DETACHED );
    pthread_create(
         &tid, &pattr, thread_start, (void *) 12345L );
    //pthread_join( tid, NULL );
    cout << "sleeping" << endl;
    sleep( 20 );
    return( 0 );
};
