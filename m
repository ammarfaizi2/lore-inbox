Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVESWbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVESWbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 18:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVESWbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 18:31:12 -0400
Received: from smtp04.auna.com ([62.81.186.14]:49326 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261289AbVESWai convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 18:30:38 -0400
Date: Thu, 19 May 2005 22:30:32 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Illegal use of reserved word in system.h
To: linux-kernel@vger.kernel.org
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
	<20050518195337.GX5112@stusta.de>
	<6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com>
	<20050519112840.GE5112@stusta.de>
	<Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com>
	<1116505655.6027.45.camel@laptopd505.fenrus.org>
	<428CCD19.6030909@candelatech.com> <428CCE87.2010308@nortel.com>
	<428CCFA7.6010206@candelatech.com> <jeacmqg8ww.fsf@sykes.suse.de>
In-Reply-To: <jeacmqg8ww.fsf@sykes.suse.de> (from schwab@suse.de on Fri May
	20 00:14:55 2005)
X-Mailer: Balsa 2.3.2
Message-Id: <1116541832l.2940l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.219.120] Login:jamagallon@able.es Fecha:Fri, 20 May 2005 00:30:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.20, Andreas Schwab wrote:
> Ben Greear <greearb@candelatech.com> writes:
> 
> > Chris Friesen wrote:
> >> Ben Greear wrote:
> >> 
> >>> It can be helpful to know what HZ you are running at, for instance if
> >>> you care
> >>> very much about the (average) precision of a select/poll timeout.
> >> If you move the binary to a different system (or upgrade the kernel, for
> >> that matter) the assumptions can be totally wrong.
> >> This should be checked at runtime, not compile time.
> >
> > If course...that is why I like the idea of some system call or standard API
> > to get the information.
> 
> sysconf(3)
> 

Yup, I do it to start a thread per core.
Stupid and portable C++ code follows:

//! Node Information
__class Node {
private:
    static void init();
public:
    //! Node name
    static char name[MAXNAMLEN];
    //! Node model name
    static char model[MAXNAMLEN];
    //! Node hardware architecture
    static char arch[MAXNAMLEN];
    //! Node Operating Node name
    static char osname[MAXNAMLEN];
    //! Node Operating Node release
    static char osrel[MAXNAMLEN];
    //! Node memory
    static int  ram;
    //! Node number of available processors
    static int  nproc;
};

#ifdef __UNX__

# include <unistd.h>

# ifdef sgi
#  include <sys/systeminfo.h>
#  include <invent.h>
# endif

# ifdef __linux__
#  include <sys/sysinfo.h>                                   
# endif

# ifdef sun
#  include <sys/systeminfo.h>
# endif

# ifdef __hpux
extern "C" {
#  include <sys/mpctl.h>
}
# endif

#endif

int  Node::inited = 0;
char Node::name[MAXNAMLEN];
char Node::model[MAXNAMLEN];
char Node::arch[MAXNAMLEN];
char Node::osname[MAXNAMLEN];
char Node::osrel[MAXNAMLEN];
int	 Node::ram;
int	 Node::nproc;

void Node::init()
{
	if (inited) return;

	nproc = 1;
	ram = 0;

#if defined(__UNX__)
	struct utsname sys;
	uname(&sys);
	strcpy(name,sys.nodename);
	strcpy(model,sys.machine);
	strcpy(osname,sys.sysname);
	strcpy(osrel,sys.release);
# ifdef sgi
	sysinfo(SI_ARCHITECTURE,arch,MAXNAMLEN);
	nproc = sysconf(_SC_NPROC_ONLN);
	inventory_t* ip;
	while (ip=getinvent())
	{
		if ((ip->inv_class==INV_MEMORY) && (ip->inv_type==INV_MAIN))
			ram = ip->inv_state;
	}
	endinvent();
# endif
# ifdef sun
	sysinfo(SI_ARCHITECTURE,arch,MAXNAMLEN);
	nproc = sysconf(_SC_NPROCESSORS_ONLN);
	ram = sysconf(_SC_PAGESIZE)*sysconf(_SC_PHYS_PAGES);
# endif
# ifdef __linux__
	strcpy(arch,"x86");
	nproc = sysconf(_SC_NPROCESSORS_ONLN);
	if (!nproc) nproc = 1;
	ram = sysconf(_SC_PAGESIZE)*sysconf(_SC_PHYS_PAGES);
# endif
# ifdef __hpux
	strcpy(arch,"PA-RISC");
	nproc = mpctl(MPC_GETNUMSPUS,0,0);
	ram = 0; // TODO...
# endif

#elif defined(__WIN__)
	DWORD	len=MAXNAMLEN;
	GetComputerNameA(name,&len);
	strcpy(model,"Intel");
	SYSTEM_INFO	sys;
	GetSystemInfo(&sys);
	nproc = sys.dwNumberOfProcessors;
	sprintf(arch,"i%d86",sys.wProcessorLevel);
	MEMORYSTATUS minfo;
	GlobalMemoryStatus(&minfo);
	ram = minfo.dwTotalPhys;
	OSVERSIONINFO	osver;
	osver.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
	GetVersionEx(&osver);
	int relmaj = osver.dwMajorVersion;
	int relmin = osver.dwMinorVersion;
	switch(osver.dwPlatformId)
	{
		case VER_PLATFORM_WIN32s:
			strcpy(osname,"Win3.1");
			break;
		case VER_PLATFORM_WIN32_WINDOWS:
			sprintf(osname,"Win9%c",(relmin>0 ? '8' : '5'));
			break;
		case VER_PLATFORM_WIN32_NT:
			strcpy(osname,"WinNT");
			break;
		default:
			strcpy(osname,"Win??");
	}

	sprintf(osrel,"%d.%d (build %d) %s",
		relmaj,relmin,osver.dwBuildNumber,osver.szCSDVersion);

#else

	strcpy(name,"Unknown");
	strcpy(model,"Unknown");
	strcpy(arch,"Unknown");
	strcpy(osname,"Unknown");
	strcpy(osrel,"?.?");

#endif

	inited = 1;

	info();
}

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam19 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


