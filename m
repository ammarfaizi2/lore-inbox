Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWHOQCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWHOQCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbWHOQCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:02:48 -0400
Received: from web36601.mail.mud.yahoo.com ([209.191.85.18]:12979 "HELO
	web36601.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965244AbWHOQCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:02:47 -0400
Message-ID: <20060815160246.81566.qmail@web36601.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 15 Aug 2006 09:02:45 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] [PATCH] file posix capabilities
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
       chrisw@sous-sol.org
In-Reply-To: <20060814220651.GA7726@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1710943684-1155657765=:80585"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1710943684-1155657765=:80585
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline



--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:


> +
> +	bprm->cap_effective = fscaps[0];
> +	bprm->cap_inheritable = fscaps[1];
> +	bprm->cap_permitted = fscaps[2];
> +

It does not appear that you're attempting
to maintain the POSIX exec semantics for
capability sets. (If you're doing it
elsewhere in the code, nevermind) I don't
know if this is intentional or not.
I will have a closer look, but just for
grins, I've attached code from the SGI
OB1 offering of some years back that
includes a function, cap_recalc, that
implements the correct behavior. I will
also take a stab at working it in, but
I expect someone will beat me to it.


Casey Schaufler
casey@schaufler-ca.com
--0-1710943684-1155657765=:80585
Content-Type: text/plain; name="capability.c"
Content-Description: 1104682580-capability.c
Content-Disposition: inline; filename="capability.c"

/*
 * 
 * Copyright 1990 Silicon Graphics, Inc. 
 * All rights reserved.
 *     
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */
#ident	"$SGIRevision: 1.30 $"

#include "sys/types.h"
#include "sys/systm.h"
#include "sys/debug.h"
#include "sys/cmn_err.h"
#include "ksys/cred.h"
#include "sys/proc.h"
#include "sys/vfs.h"
#include "sys/param.h"
#include "sys/errno.h"
#include "sys/vfs.h"
#include "sys/vnode.h"
#include "sys/fstyp.h"
#include "ksys/vfile.h"
#include "ksys/fdt.h"
#include "sys/uio.h"
#include "sys/pathname.h"
#include "sys/capability.h"
#include "sys/sat.h"
#include "sys/attributes.h"
#include "os/proc/pproc_private.h"	/* XXX bogus */
#include "ksys/fdt.h"
#include "sys/uthread.h"

/*
 * Make the default be augmented superuser.
 */
void
cap_init()
{
	cap_enabled = CAP_SYS_SUPERUSER;
}

/*
 * Give the requested credential all privileges.
 * This is used to initialize sys_cred and NFS server credentials.
 */
void
cap_empower_cred(cred_t *cr)
{
	cr->cr_cap.cap_effective = CAP_ALL_ON;
	cr->cr_cap.cap_inheritable = CAP_ALL_ON;
	cr->cr_cap.cap_permitted = CAP_ALL_ON;
}

int
cap_vtocap(vnode_t *vp, cap_t capp)
{
	int error;
	int i = sizeof(cap_set_t);

	VOP_ATTR_GET(vp, SGI_CAP_FILE, (char *)capp, &i, ATTR_ROOT,
	    sys_cred, error);

	return error;
}

/*
 * Recalculate the process capabilities appropriate after exec(2).  Uses the
 * POSIX P1003.1eD16 algorythm.  For exec()'s of SCAP files:
 *
 *     New-inheritable = Proc-inheritable & File-inheritable
 *     New-permitted   = (New-inheritable & Proc-permitted) | File-permitted
 *     New-effective   = File-effective & New-permitted
 *
 * For exec()'s of non-SCAP files when the current cap_inheritable has
 * CAP_FLAG_PURE_RECALC set we drop all capabilities.  Otherwise we leave
 * the process' current capabilities alone.
 *
 * Called with proposed new capabilities from file, "fcap" (which will be
 * invalid if the file doesn't have any attached capabilities).  Returns with
 * recalculated capabilities in *current* process credentials.  Also returns
 * whether or not the calculation resulted in an increase in capabilities.
 * Must be called with pcred_lock() set.
 */
int
cap_recalc(const cap_set_t *fcap)
{
	uthread_t *ut = curuthread;
	proc_t *p = UT_TO_PROC(ut);	/* XXX virtualize this? */
	cred_t *cr = p->p_cred;
	cap_set_t *pcap = &cr->cr_cap;
	int rxev;

	/*
	 * This routine is called only from exec, so there's only one
	 * uthread, and we don't have to pcred_push() the changes to the
	 * uthread.  Also assert that we have the credentials lock ...
	 */
	ASSERT(!(ut->ut_flags & UT_PTHREAD));
	ASSERT(pcred_islocked(p));

	if (fcap->cap_effective & CAP_INVALID) {
		/*
		 * File didn't have any capabilities attached to it.  If
		 * CAP_FLAG_PURE_RECALC is set clear any capabilities.
		 * Otherwise, leave everything alone and return.  Note: We
		 * oughtn't need to retain the CAP_FLAG_PURE_RECALC flag.
		 */
		if (pcap->cap_inheritable & CAP_FLAG_PURE_RECALC) {
			#pragma mips_frequency_hint NEVER
			pcap->cap_effective   = CAP_ALL_OFF;
			pcap->cap_permitted   = CAP_ALL_OFF;
			pcap->cap_inheritable = CAP_FLAG_PURE_RECALC;
		}
		rxev = 0;
	} else {
		#pragma mips_frequency_hint NEVER
		cap_set_t opcap = *pcap;

		pcap->cap_inheritable = CAP_ALL_ON & 
			(pcap->cap_inheritable & fcap->cap_inheritable);
		pcap->cap_permitted = CAP_ALL_ON & 
			((pcap->cap_inheritable & pcap->cap_permitted) |
			 fcap->cap_permitted);
		pcap->cap_effective = CAP_ALL_ON &
			(fcap->cap_effective & pcap->cap_permitted);

		rxev = ((pcap->cap_effective   & ~opcap.cap_effective) ||
			(pcap->cap_permitted   & ~opcap.cap_permitted) ||
			(pcap->cap_inheritable & ~opcap.cap_inheritable));
	}

	if ((pcap->cap_effective & CAP_ALL_ON) ||
	    (pcap->cap_permitted & CAP_ALL_ON))
		p_flagset(p, SPRPROTECT);
	else
		p_flagclr(p, SPRPROTECT);

	return rxev;
}

int
cap_setpcap(cap_set_t *src, cap_value_t *flags)
{
	struct cred *cr;
	/* REFERENCED */
	proc_t *pp = curprocp;

	if (flags != NULL) {
		ASSERT(src == NULL);
		cr = pcred_lock(pp);
		cr = crcopy(pp);
		cr->cr_cap.cap_inheritable =
		    (cr->cr_cap.cap_inheritable & CAP_ALL_ON) |
		    (*flags & CAP_FLAGS);
		pcred_push(pp);
		return 0;
	}

	ASSERT(src != NULL);

	if ((src->cap_inheritable & CAP_INVALID) ||
	    (src->cap_permitted & CAP_INVALID) ||
	    (src->cap_effective & CAP_INVALID))
		return EINVAL;

	/*
	 * Clear any flag bits in the new set.
	 */
	src->cap_inheritable &= CAP_ALL_ON;
	src->cap_permitted &= CAP_ALL_ON;
	src->cap_effective &= CAP_ALL_ON;

	/*
	 * Audit the old capability set
	 */
	_SAT_SAVE_ATTR(SAT_CAP_SET_TOKEN, curuthread);

	cr = pcred_lock(pp);

	if ((!CAP_ID_ISSET(src->cap_inheritable,
			   cr->cr_cap.cap_inheritable) &&
	     !CAP_ID_ISSET(src->cap_inheritable,
			   cr->cr_cap.cap_permitted)) ||
	    (!CAP_ID_ISSET(src->cap_permitted, cr->cr_cap.cap_permitted)) ||
	    (!CAP_ID_ISSET(src->cap_effective, cr->cr_cap.cap_effective) &&
	     !CAP_ID_ISSET(src->cap_effective, cr->cr_cap.cap_permitted))) {
		if (!cap_able(CAP_SETPPRIV)) {
			pcred_push(pp);
			_SAT_SETPCAP(src, EPERM);
			return EPERM;
		}
	}

	/*
	 * Retain the flags stored in the inheritable set.
	 */
	src->cap_inheritable |= cr->cr_cap.cap_inheritable & CAP_FLAGS;

	/*
	 * At this point we are going to set the requested capability state
	 * so, check whether the process will have any permitted or effective
	 * capabilities after the call is over.  If so, taint the process
	 * so that access through /proc is privileged from now on (until
	 * the next exec())
	 */
	if (   (src->cap_permitted & CAP_ALL_ON)
	    || (src->cap_effective & CAP_ALL_ON)) {
		p_flagset(pp, SPRPROTECT);
	}

	/*
	 * Set the requested capability state.
	 */
	cr = crcopy(pp);
	cr->cr_cap = *src;
	pcred_push(pp);

	_SAT_SETPCAP(src, 0);
	return 0;
}

int
cap_request(cap_value_t cid)
{
	proc_t *pp = curprocp;
	struct cred *cr = pcred_lock(pp);

	if (CAP_ID_ISSET(cid, cr->cr_cap.cap_permitted)) {
		if (!CAP_ID_ISSET(cid, cr->cr_cap.cap_effective)) {
			cr = crcopy(pp);
			CAP_ID_SET(cid, cr->cr_cap.cap_effective);
			pcred_push(pp);
		} else
			pcred_unlock(pp);
		return 0;
	}
	pcred_unlock(pp);
	return EPERM;
}


int
cap_surrender(cap_value_t cid)
{
	proc_t *pp = curprocp;
	struct cred *cr = pcred_lock(pp);

	if (CAP_ID_ISSET(cid, cr->cr_cap.cap_effective)) {
		cr = crcopy(pp);
		CAP_ID_CLEAR(cid, cr->cr_cap.cap_effective);
		pcred_push(pp);
	} else
		pcred_unlock(pp);
	return 0;
}

/*
 * cap_get - get the capability set of a file
 *
 * Returns 0 on success.
 * Returns ENOATTR if no capability set is associated with the file.
 */

int
cap_get(char *fname, int fdes, struct cap_set *cap)
{
	struct cap_set kcap;
	vfile_t *fp;
	vnode_t *vp;
	int error = 0;

	if (fdes != -1 && fname != NULL)
		return (EINVAL);
	if (fdes == -1 && fname == NULL)
		return (EINVAL);

	if (!cap)
		return (EINVAL);

	_SAT_PN_BOOK(SAT_FILE_ATTR_READ, curuthread);

	if (fname) {
		if (error=lookupname(fname,UIO_USERSPACE,NO_FOLLOW,NULLVPP,&vp,						NULL))
			return (error);
	}
	else {
		if (error = getf(fdes, &fp))
			return (error);
		if (!VF_IS_VNODE(fp))
			return (EINVAL);
		vp = VF_TO_VNODE(fp);

		VN_HOLD(vp);
	}

	if (!(error = _MAC_VACCESS(vp, curuthread->ut_cred, VREAD)))
	    error = cap_vtocap(vp, &kcap); /* Returns ENOATTR if no capability set */

	if (!error) {
		if (copyout((caddr_t)&kcap,(caddr_t)cap,sizeof(struct cap_set)))
			error = EFAULT;
	}
	
	VN_RELE(vp);

	_SAT_ACCESS(SAT_FILE_ATTR_READ, error);
	return (error);
}

/*
 * cap_set - set the capability set on a file
 *
 * If cap is a null pointer, the capability set is removed from
 * the file.
 *
 * Returns 0 on success.
 */

int
cap_set(char *fname, int fdes, struct cap_set *cap)
{
	struct cap_set kcap;
	vnode_t *vp;
	vfile_t *fp;
	int error;

	if (!_CAP_ABLE(CAP_SETFCAP))
		return (EPERM);

	if (fdes != -1 && fname != NULL)
		return (EINVAL);
	if (fdes == -1 && fname == NULL)
		return (EINVAL);


	if (cap && copyin((caddr_t)cap, (caddr_t)&kcap, sizeof(struct cap_set)))
		return (EFAULT);

	_SAT_PN_BOOK(SAT_FILE_ATTR_WRITE, curuthread);

	if (fname) {
		if (error=lookupname(fname,UIO_USERSPACE,NO_FOLLOW,NULLVPP,&vp,						NULL))
			return (error);
	}
	else {
		if (error = getf(fdes, &fp))
			return (error);
		if (!VF_IS_VNODE(fp))
			return (EINVAL);
		vp = VF_TO_VNODE(fp);
		VN_HOLD(vp);
	}

	/*
	 * MAC and ownership checks.
	 */
	if (!(error = _MAC_VACCESS(vp, curuthread->ut_cred, VWRITE))) {
		vattr_t va;

		va.va_mask = AT_UID;
		VOP_GETATTR(vp, &va, 0, sys_cred, error);

		if (!error && va.va_uid != curuthread->ut_cred->cr_uid &&
		    !_CAP_CRABLE(curuthread->ut_cred, CAP_FOWNER))
			error = EACCES;
	}

	if (!error) {
		/*
		 * Only regular files should have cap sets.
		 * Better not try to update a read-only file system.
		 */
		if (vp->v_type != VREG)
			error = EINVAL;
		else if (vp->v_vfsp->vfs_flag & VFS_RDONLY)
			error = EROFS;
		else if ( cap )
		{
			VOP_ATTR_SET(vp, SGI_CAP_FILE, (char *)cap,
			    sizeof(cap_set_t), ATTR_ROOT, sys_cred, error);
		}
		else
		{
		        VOP_ATTR_REMOVE(vp, SGI_CAP_FILE, ATTR_ROOT, sys_cred, error);
			if ( error == ENOATTR )
			    /* There already was no capability associated with the file */
			    error = 0;
		}
	}

	VN_RELE(vp);
	_SAT_SETCAP( cap, error );
	return (error);
}

int
cap_style(int new)
{

#ifdef DEBUG
	if (cap_enabled == CAP_SYS_SUPERUSER)
		cmn_err(CE_NOTE,"Superuser and capabilities provide privilege");
	else if (cap_enabled == CAP_SYS_NO_SUPERUSER)
		cmn_err(CE_NOTE,"Capabilities alone provide privilege");
	else if (cap_enabled == CAP_SYS_DISABLED)
		cmn_err(CE_NOTE,"Superuser alone provides privilege");
#endif /* DEBUG */

	if (!_CAP_ABLE(CAP_SYSINFO_MGT))
		return (EPERM);

#ifdef DEBUG
	if (new == CAP_SYS_SUPERUSER)
		cmn_err(CE_NOTE,
		    "Now, Superuser and capabilities provide privilege");
	else if (new == CAP_SYS_NO_SUPERUSER)
		cmn_err(CE_NOTE,"Now, Capabilities alone provide privilege");
	else if (new == CAP_SYS_DISABLED)
		cmn_err(CE_NOTE,"Now, Superuser alone provides privilege");
#endif /* DEBUG */
	cap_enabled = new;
	return (0);
}

--0-1710943684-1155657765=:80585--
