Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318966AbSIDAbo>; Tue, 3 Sep 2002 20:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318973AbSIDAbo>; Tue, 3 Sep 2002 20:31:44 -0400
Received: from mailf.telia.com ([194.22.194.25]:64244 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S318966AbSIDAbh>;
	Tue, 3 Sep 2002 20:31:37 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Subject: [SOURCE] RT monitor (Was: Re: Problem with the O(1) scheduler in 2.4.19)
Date: Wed, 4 Sep 2002 02:34:46 +0200
User-Agent: KMail/1.4.6
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209031322210.7658-100000@boris.prodako.se>
In-Reply-To: <Pine.LNX.4.44.0209031322210.7658-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mUVd99iyhv9n9nl"
Message-Id: <200209040234.46911.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_mUVd99iyhv9n9nl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tuesday 03 September 2002 14.23, Tobias Ringstrom wrote:
> I see three simple ways to solve the problem without changing the
> scheduler.  Either run the process with nice -20, use SCHED_RR, or use a
> dedicated server with no other processes (such as crond, httpd, etc).  
> The first two might be OK, but you need root privilegies to run renice and
> to change the scheduler policy.  The third one is not an option for all
> users, and definately not for the video playback case.
> 

Here comes some code that works as a RT requester/monitor and
an small utility to try it out.

With this monitor any process can request RT priorities.
If those (or other) processes overloads the system,
all will be returned to normal priorities.

Note:
* this code is still experimental. I had a situation where
   a previous monitor reduced its own priority... (rendering it useless)
* It does probably not work on SMP - I have not given that
   much of a thought yet...

compile the source:
        gcc -Wall rt.c -o rt
        gcc -Wall rt_monitor.c -o rt_monitor

then as root:
        mkfifo -m 622 /var/named/rt-request
        ./rt_monitor

start another shell (as a normal user - not root)
to check the function of the monitor (sleeps 3 s then loops,
the monitor should reduce the priority in about 4 seconds)
        ./rt -c

to set RT priority on any process do
(note: this should be quite safe since the monitor does the raising
so it has to be running :-)
	./rt -p anypid 


/RogerL
-- 
Roger Larsson
Skellefteå
Sweden

--Boundary-00=_mUVd99iyhv9n9nl
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="rt.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rt.c"

/* RT user.

        Copyright (c) 2002 Roger Larsson <roger.larsson@norran.net>

    This program is free software; you can redistribute it and/or
    modify it under the terms of version 2 of the GNU General Public
    License as published by the Free Software Foundation.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    Thanks to autor of KSysGuard Chris Schlaeger for borrowed code...
*/

#include <sys/types.h>
#include <sched.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>

struct request
{
	pid_t pid;
	char _filler[32];
};


int main(int argc, char *argv[])
{
	struct request request;
	FILE *reqf;
	int done=0, loops = 0;

	request.pid = getpid();
	while (!done) {
	    switch (getopt(argc, argv, "?c:p:" )) {
		case 'c':
		    loops = atoi(optarg);
		    break;
		case 'p':
		    request.pid = atoi(optarg);
		    printf("pid %d\n", request.pid);
		    break;
		case '?':
		    printf("%s: [-c|-p pid]\n", argv[0]);
		    printf("\t-c loops\tcheck monitor function by looping\n");
		    printf("\t-p pid\trequest on behalf of other process\n");
		    return 1;
		case -1:
		    // No more options
		    done = 1;
		    break;
	    }
	}

	printf("As long as no monitor runs, execution will sleep here...\n");
	reqf = fopen("/var/named/rt-request", "w");
	if (reqf == NULL) {
	    perror("fopen");
	    return errno;
	}

	printf("policy %d\n", sched_getscheduler(request.pid));


	fwrite(&request, 32, 1, reqf);
	fclose(reqf); // important! (maybe flush?)

	printf("policy %d\n", sched_getscheduler(request.pid));

	// well behaved
	if (request.pid == getpid() && loops > 0) {
	    // Wait until RT prio raised
	    while (sched_getscheduler(request.pid) == 0) {
	    }

	    printf("\nsleep for 3 seconds then start with a\n");
	    printf("busy wait for %d loops (or until prio reduced)\n", loops);
	    printf(" move your mouse!\n");
	    sleep(3);

	    while (--loops > 0 && sched_getscheduler(request.pid) != 0) {
		// someone did listen to my request...
		// assume monitor is running
	    }

	    if (loops == 0)
		printf(" - normal loop finish, to short loop?\n");
	    else
		printf(" - monitor works! (priority got reduced)\n");
	}

	return 0;
}

--Boundary-00=_mUVd99iyhv9n9nl
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="rt_monitor.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rt_monitor.c"

/* RT monitor.

        Copyright (c) 2002 Roger Larsson <roger.larsson@norran.net>

    This program is free software; you can redistribute it and/or
    modify it under the terms of version 2 of the GNU General Public
    License as published by the Free Software Foundation.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    Thanks to autor of KSysGuard Chris Schlaeger for borrowed code...
*/

#include <sys/types.h>
#include <sched.h>
#include <stdio.h>
#include <dirent.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <ctype.h>
#include <sys/time.h>
#include <stdlib.h>


int set_normal_priority(pid_t pid);



 int isRT(pid_t pid)
 {
     int sched_class = sched_getscheduler( pid);
     if (sched_class == -1) {
	 fprintf(stderr, "Pid %d Exited?\n", pid);
	 return 0;
     }

     return sched_class != SCHED_OTHER;
 }

struct rt_process_info
{
    /* This flag is set for all found processes at the beginning of the
     * process list update. Processes that do not have this flag set will
     * be assumed dead and removed from the list. The flag is cleared after
     * each list update. */
    int alive;
    int centStamp;


    pid_t pid;
    pid_t ppid;
    gid_t gid;

    unsigned int userTime;
    unsigned int sysTime;
    unsigned int vmSize; // enough?
    unsigned int vmRss; // enough?

    float sysLoad;
    float userLoad;
    float cpu_usage;
};

#define MAX_RT_PROCESSES 200
struct rt_process_info rt_process[MAX_RT_PROCESSES]; /* pid & alive == 0 */

struct rt_process_info *find_process(pid_t pid)
{
    unsigned ix;
    for (ix = 0; ix < MAX_RT_PROCESSES; ix++)
    {
	if (rt_process[ix].pid == pid) {
	    rt_process[ix].alive = 1;
	    return &rt_process[ix];
	}
    }

    return NULL;
}

struct rt_process_info *new_process(pid_t pid)
{
    unsigned ix;
    for (ix = 0; ix < MAX_RT_PROCESSES; ix++)
    {
	if (rt_process[ix].pid == 0) {
	    rt_process[ix].pid = pid;
	    rt_process[ix].alive = 2;
	    return &rt_process[ix];
	}
    }

    return NULL;
}

float cpu_usage(struct rt_process_info *ps)
{
#define BUFSIZE 1024
    char buf[BUFSIZE];
    FILE *fd;
    char status;
    unsigned int userTime, sysTime;

    snprintf(buf, BUFSIZE - 1, "/proc/%d/stat", ps->pid);
    buf[BUFSIZE - 1] = '\0';
    if ((fd = fopen(buf, "r")) == 0)
	return (-1);

    if (fscanf(fd, "%*d %*s %c %d %d %*d %*d %*d %*u %*u %*u %*u %*u %d %d"
	       "%*d %*d %*d %*d %*u %*u %*d %u %u",
	       &status, (int*) &ps->ppid, (int*) &ps->gid,
	       &userTime, &sysTime, &ps->vmSize,
	       &ps->vmRss) != 7) {
	fclose(fd);
	return (-1);
    }

    if (fclose(fd))
	return (-1);

    {
	unsigned int newCentStamp;
	int timeDiff, userDiff, sysDiff;
	struct timeval tv;

	gettimeofday(&tv, 0);
	newCentStamp = tv.tv_sec * 100 + tv.tv_usec / 10000;

	// calculate load
	if (ps->alive == 2)
	    ps->sysLoad = ps->userLoad = 0.0f; /* can't give relieable number at the moment... */
	else {
	    timeDiff = (int)(newCentStamp - ps->centStamp);
	    userDiff = userTime - ps->userTime;
	    sysDiff = sysTime - ps->sysTime;

			
	    if ((timeDiff > 0) && (userDiff >= 0) && (sysDiff >= 0)) /* protect from bad data */
	    {
		ps->userLoad = ((double) userDiff / timeDiff) * 100.0;
		ps->sysLoad = ((double) sysDiff / timeDiff) * 100.0;
	    }
	    else
		ps->sysLoad = ps->userLoad = 0.0;
	}

	// update fields
	ps->centStamp = newCentStamp;
	ps->userTime = userTime;
	ps->sysTime = sysTime;
    }
	
    ps->cpu_usage = ps->userLoad + ps->sysLoad;

    return ps->cpu_usage;
}

float process_cpu_usage(pid_t pid)
{
    struct rt_process_info *process = find_process(pid);
    float cpu_use;

    if (process == NULL)
    {
	process = new_process(pid);
	if (process == NULL) {
	    // to many RT processes!
	    //  this process is new - assume a DOS attack
	    printf("Out of RT process info space - "
		   "assume DOS attack\n");
	    set_normal_priority(pid);
	}

						
	process->alive = 2; /* mark process new */
    }

    cpu_use = cpu_usage(process);

    process->alive = 1;

    return cpu_use;
}

/* process reading code from ksysguard */
float cpu_rt_usage(struct rt_process_info **rt_list_head)
{
    // Watch out for SMP effects...
	
    float result = 0.0f;
    pid_t myself = getpid();
    DIR* dir;
    struct dirent* entry;

    /* read in current process list via the /proc filesystem entry */
    if ((dir = opendir("/proc")) == NULL)
    {
	perror("Cannot open directory \'/proc\'!\n"
	       "The kernel needs to be compiled with support\n"
	       "for /proc filesystem enabled!\n");
	return 0;
    }
	
    // for all processes
    while ((entry = readdir(dir)))
    {
	if (isdigit(entry->d_name[0]))
	{
	    pid_t pid;

	    pid = atoi(entry->d_name);
			
	    if (pid != myself && isRT(pid)) {
		result += process_cpu_usage(pid);
	    }
	}
    }
    closedir(dir);
	
    return result;
}


void gc_rt_processes()
{
    unsigned ix;
    for (ix = 0; ix < MAX_RT_PROCESSES; ix++)
    {
	struct rt_process_info *rt_examine = &rt_process[ix];

	if (rt_examine->alive)
	{
	    rt_examine->alive = 0;
	}
	else
	{
	    rt_examine->pid = 0; /* delete it! */
	}
    }
}

int set_me_realtime(void)
{
struct sched_param schp;
	/*
	 * set the process to realtime privs
	 */
        memset(&schp, 0, sizeof(schp));
	schp.sched_priority = sched_get_priority_max(SCHED_FIFO);

	if (sched_setscheduler(0, SCHED_FIFO, &schp) != 0) {
		perror("sched_setscheduler");
		return -1;
	}

	if(mlockall(MCL_CURRENT|MCL_FUTURE))
	{
	    perror("mlockall() failed, exiting. mlock");
	    return -1;
	}

	return 0;

}

int set_realtime_priority(pid_t pid)
{
	struct sched_param schp;
	/*
	 * set the process to realtime privs
	 */

	printf("Attempt to set realtime for pid %d ", pid);

	if (pid == 0 || pid == getpid()) {
	    printf("- ignored! (that is me)\n");
	    return -1;
	}


        memset(&schp, 0, sizeof(schp));
	schp.sched_priority = sched_get_priority_min(SCHED_FIFO);

	if (sched_setscheduler(pid, SCHED_FIFO, &schp) != 0) {
		printf("- failed!\n");
		perror("sched_setscheduler");
		return -1;
	}
	printf("- done!\n");

	(void)process_cpu_usage(pid);

	return 0;

}

int set_normal_priority(pid_t pid)
{
struct sched_param schp;
	/*
	 * set the process to realtime privs
	 */
        memset(&schp, 0, sizeof(schp));
	schp.sched_priority = 0;

	printf("Attempt to reduce scheduling class for pid %d ", pid);

	if (pid == 0 || pid == getpid()) {
	    printf("- ignored! (that is me)\n");
	    return -1;
	}

	if (sched_setscheduler(pid, SCHED_OTHER, &schp) != 0) {
		printf("- failed!\n");
		perror("sched_setscheduler");
		return -1;
	}
	printf("- done!\n");

	return 0;
}

void set_normal_priority_all()
{
    unsigned ix;
    for (ix = 0; ix < MAX_RT_PROCESSES; ix++)
    {
	struct rt_process_info *process_info = &rt_process[ix];
	if (process_info->pid)
	    set_normal_priority(process_info->pid);
    }
}

struct request
{
	pid_t pid;
	char	_filler[32];
};
	
#define REQUEST_SIZE 32

int poll_request(int reqfd)
{
    // Be VERY careful not to
    // * block here...
    // * get buffer overruns...

	static int remaining = REQUEST_SIZE;
	static struct request request;
	char *next = ((char *)&request + REQUEST_SIZE - remaining);

	int ret = read(reqfd, (void *)next, remaining);
	if (ret == -1) {
		perror("read");
		return 0;
	}
	remaining -= ret;

	if (remaining == 0) {
		remaining = REQUEST_SIZE;

		if (request.pid == 0 || request.pid == getpid()) {
			fputs("attempt to forge the monitor\n", stderr);
			return 0;
		}

		set_realtime_priority(request.pid);

		return 1;
	}

	return 0;
}

#define RTREQUEST_FILE "/var/named/rt-request" 
int main(int argc, char * argv[])
{
    struct rt_process_info *rt_list = NULL;
    int reqfd = open(RTREQUEST_FILE,  O_RDONLY | O_NONBLOCK | O_NDELAY);

    if (reqfd == -1) {
	perror("open " RTREQUEST_FILE);
	fputs("have you created it? use 'mkfifo -m 622 " RTREQUEST_FILE "'\n", stderr);
	exit(1);
    }
      
    // monitor process runs with realtime prio
    set_me_realtime();

 #define MIN_IDLE 10
 #define MAX_RT_USAGE 70

    while (1) {
	poll_request(reqfd);

		
	if (cpu_rt_usage(&rt_list) > MAX_RT_USAGE) {
	    printf("Total CPU RT usage above MAX_RT_USAGE\n");
	    
	    gc_rt_processes();

	    // build process trees from rt_list
	    // decide which tree to reduce to normal prio class
	    //   (assume only one for simplicitly...)
	    
	    // reduce all processes in that tree
	    set_normal_priority_all();

	    //   (may use nice to simulate prio levels)
	    // log a message

	}
	sleep(2);
    }
    
    // process exiting - free elements on rt_list...
    //free_rt_list(rt_list);
}


--Boundary-00=_mUVd99iyhv9n9nl--

