Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265867AbUAEDfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265868AbUAEDfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:35:37 -0500
Received: from w100.z064003144.sjc-ca.dsl.cnc.net ([64.3.144.100]:54723 "EHLO
	adrian.mariani.ws") by vger.kernel.org with ESMTP id S265867AbUAEDe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:34:59 -0500
Message-ID: <3FF8DB62.1070406@mariani.ws>
Date: Sun, 04 Jan 2004 19:34:58 -0800
From: Gianni Mariani <gianni@mariani.ws>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible SMP Race - 2.4.20-8smp - RH9 ?
Content-Type: multipart/mixed;
 boundary="------------000504040402050108040000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000504040402050108040000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I've attached an old CPU memory latentcy test that ram quite happily on 
linux SMP machines until today.

I have a Dual AMD 2400 with an MSI K7D-Master, IG RAM.

The problem is that the test segfaults in random places.

The code is quite simple, using fork and a shared mmap()ed file.

Code goes like this:

Map a temp file shared.
initialize some ptrs.
fork
    - child busy loops reading data from shared memory
    - parent busy waits (using tsc) then sets mem location
    - child pops out of loop and also reads tsc
    - parent busy loops reading data from shared memory
    - child busy waits (using tsc) then sets mem location
    etc etc

Core files indicate that the memory is unavailable however gdb indicates 
that the memory is readable.

I'm downloading 2.4.23 and I'll give that a go later.

If anyone wants to try it for me on a 2.6 or a 2.4.23 kernel I'd 
appreciate that.  This could concievably be a hardware problem but that 
seems unlikely since the machine has been very stable for quite a while.

Ideas ?

--------------000504040402050108040000
Content-Type: text/plain;
 name="cpulat.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpulat.cpp"

//
// cpulat.cpp
//	Authored by Gianni Mariani 13-Jun-1999
//
//	This is intended to run on a dual CPU PII or better system.
//	This measures the latentcy in CPU clock cycles from one
//  CPU making a change to memory to the other CPU being able to
//	react.  This latentcy is a critical factor in shared memory
//  parallel communications.
//	
//
//  LICENSE - GPL - GNU Public Licencse
//
// Description
//	This program sets up a page of shared memory and then forks.
//	Each process will share the page of memory and will use it
//  to do raw shared memory spin locks using a simple while()
//	loop.
//
//	The child process goes into a spin and the parent process
//	wakes breaks it's spin.  Both processes read their respective
//	time stamps just after these events.  The parent process waits
//	for the child to place the counter value in the shared memory
//	and then measures the difference.  The roles are then reversed
//	and this interaction is measured 10 times.
//
//	If the time stamp counters are not set up correctly by the OS
//	you will get weird behaviour.
//
//	This is the output of a run on a Tyan S1837 with PIII 450's using
//	a stock RH 6.0 (2.2.5-15smp) Linux kernel.
//
//	diff = 165
//	odiff = 187
//	diff = 201
//	odiff = 175
//	diff = 194
//	odiff = 166
//	diff = 192
//	odiff = 182
//	diff = 186
//	odiff = 169
//	diff = 181
//	odiff = 177
//	diff = 193
//	odiff = 170
//	diff = 162
//	odiff = 219
//	diff = 193
//	odiff = 168
//
// compile line : g++ -O2 -o cpulat cpulat.cpp
//


#include        <cstdio>
#include        <fcntl.h>
#include        <sys/types.h>
#include        <sys/time.h>
#include        <sys/types.h>
#include        <unistd.h>
#include        <sys/mman.h>
#include		<cstdlib>

using namespace std;

//
// This snippet of __asm__ magic was taken from
// a news posting.  I don't know who the original
// author is.  I did do a regular net search.
typedef unsigned long long u64;
inline u64 rdtsc(void) {
    u64 clock;
    __asm__ __volatile__("rdtsc" : "=A" (clock));
    return clock;
}

#define LOOPS 10

main()
{

    volatile char * adr;
    int             len;
    volatile u64  * data;
    int             pgsz = getpagesize();
    int             fd;
    char          * file = tmpnam( ( char * ) 0 );

    // create a temporary file
    if ( ( fd = open( file, O_RDWR | O_CREAT, 0666 ) ) == -1 ) {
bombed:
        perror( file );
        return 1;
    }

    // Delete the file now, no need to have it hang around in
	// the directory.
    unlink( file );

    // write a page to the file
    if ( lseek( fd, pgsz-1, SEEK_SET ) == (off_t)-1 ) goto bombed;
    if ( write( fd, "", 1 ) != 1 ) goto bombed;

	// Map the page to memory
    adr = ( char * ) mmap(
        ( char * ) 0,       // Address to map to
        pgsz,        // Length of the mapping
        PROT_WRITE,          // Map for read
        MAP_SHARED,         // Map a shared copy
        fd,
        0
    );

	// Check to see if the mmap went OK
    if ( -1l == ( ptrdiff_t ) adr ) goto bombed;    

	// No need for the file handle any more
    close( fd );

    * adr = 0;
    adr[ 1 ] = 0;

    data = 1 + ( u64 * ) adr;

    int procid = fork();

    if ( procid == -1 ) {
        perror( "fork()" );
        return 1;
    }

    if ( ! procid ) {

        int     n = 0;
        int     n2 = 1;

        while ( 1 ) {

            // spin and wait for the other process
            // to modify memory.
            while ( ( * adr ) == n ) ;

            // First thing - get the cpu clock time
            u64 val = rdtsc();

            // Write the time to the shared memory
            * data = val;

            n = * adr;

            // Wait a tad
            while ( rdtsc() < ( val + 450000000LL/2 ) );

            // Break the other CPU out of the spin
            adr[ 1 ] = n2;

            // Immediatly get the time
            u64 val1 = rdtsc();

            // Write it to shared memory
            data[ 1 ] = val1;

            // increment the count
            n2 ++;

            // If we've been around a few times
            // bail
            if ( n == LOOPS ) {
                exit( 0 );
            }
        }
    } else {

        int     n = 1;
        int     n2 = 0;

        // Wait for the other process to get created and spun up.
        u64 val = rdtsc();
        while ( rdtsc() < ( val + 450000000LL/4 ) );

        // Go around a bit
        for ( int i = 1; i < (LOOPS+1); i ++ ) {

            // break the other process.
            * adr = n;

            // Immediatly get the time
            u64 val = rdtsc();

            n ++;
            
            if ( n == (LOOPS+1) ) {
                exit( 0 );
            }

            // Wait about 1/4 second
            while ( rdtsc() < ( val + 450000000LL/4 ) );

            // Print out latentcy to other CPU from this CPU
            printf( "diff = %lld\n",  * data - val );

            // spin and wait for the other process
            while ( ( adr[ 1 ] ) == n2 ) ;

            // Immediatly get the time
            u64 val2 = rdtsc();

            // set the new value
            n2 = adr[ 1 ];

            // Wait for a tad.
            while ( rdtsc() < ( val + (450000000LL*3)/4 ) );

            // Print out latentcy from this CPU from other CPU
            printf( "odiff = %lld\n",  val2 - data[ 1 ] );
            
            while ( rdtsc() < ( val + 450000000LL ) );
        }

    }

    return 0;

}



--------------000504040402050108040000--

