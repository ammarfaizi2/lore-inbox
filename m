Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVAJWMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVAJWMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVAJWK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:10:26 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:39855 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262718AbVAJV6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:58:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=YO9aCS4/eu/0pgAWYu4McaEz8Qk5VDBFKbTkflOqh1gY84GEMf625VOXUZbgG1AfVy3CaB2vy/1hmZhw5ijzTpp6JePsGU7ybknxWHK4TjqYLEw7AZF18KFYvKiPWYIbShqAMcQvi5WBgYy+2sEj9cPkLeOD8k5B+4SOc7onACw=
Message-ID: <3f250c71050110135822ab66df@mail.gmail.com>
Date: Mon, 10 Jan 2005 17:58:17 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: OOM Killer user application
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here goes the OOM application:

/*  2005
 *  Bruna Moreira <bruna.moreira@indt.org.br>
 *  Edjard Mota <edjard.mota@indt.org.br>
 *  Ilias Biris <ext-ilias.biris@indt.org.br>
 *  Mauricio Lin <mauricio.lin@indt.org.br>
 * 
 *  Embedded Linux Lab - 10LE Institulo Nokia de Tecnologia - INdT 
 *
 *  Original ranking algorithm ported from kernel space to user space.
 *  This application writes the list of pids to /proc/oom based on Rik van Riel
 *  ranking algorithm from mm/oom_kill.c.
 */

#include <dirent.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <linux/timex.h>
#include <math.h>
#include <errno.h>

#if __GNUC__ > 2 || __GNUC_MINOR__ >= 96
#define likely(x)       __builtin_expect(!!(x),1)
#define unlikely(x)     __builtin_expect(!!(x),0)
#else
#define likely(x)       (x)
#define unlikely(x)     (x)
#endif

#define CAP_SYS_ADMIN 21
#define CAP_SYS_RAWIO 17

#define PID_MAX 1000

//***************************************************************
// main struct
struct pids_t 
{ 
 char pids[PID_MAX + 1];
 int points;
 struct pids_t *next;
};

//***************************************************************
// Insert new elements in the list
void insert_list(struct pids_t **first, struct pids_t aux)
{
        struct pids_t *node = NULL, *previous = NULL, *nnode;  
 
        //Creating new node
        nnode = (struct pids_t *)malloc(sizeof(struct pids_t));
        strcpy(nnode->pids, aux.pids);
        nnode->points = aux.points;
  
        if (*first) {
                node = (*first);
                //find the correct position
                while ((node) && (node->points>aux.points)) {
                        previous = node;
                        node = node->next;
                }
                if (nnode == NULL) {
                        //printf("Problem ......");
                        exit(1);
                }
                nnode->next = node;
                if (previous)
                        previous->next = nnode;
                else
                        *first = nnode;
        }
        else { 
                *first = nnode;
                (*first)->next = NULL;
        }  
}

void find_field(char *file, char *buffer, char *field)
{
        
        char* match;
        char nfield[100];
        
        strcpy(nfield, field); 
        match = strstr(file, field);
        
        if (match == NULL) {
                printf("Prooooblem ....");
        }       
        else {  
                strcat(nfield, ": %s");
        }

        sscanf(match, nfield, buffer);
        
        if (!(strcmp(field, "Uid"))) {
                strcpy(nfield, buffer);
                strcat(nfield, " ");
                match += strlen (field) + strlen(buffer) + 2;
                sscanf(match, "%s ", buffer);
                strcat(nfield, buffer); 
                strcpy(buffer, nfield);
        }
        
}

char *get_field(char *value, int field, char *result)
{
        int c;
        strcpy(result, value);
        for (c =1; c<field; c++)
                strcpy(result, strchr(result, ' ') + sizeof(char));
        
        for (c=0; result[c] != ' ' ; c++);
        result[c] = '\0';
        
        return (result);
}

int get_file(char *file, char *pid)
{
        int fd; 
        ssize_t count;
        char aux[PID_MAX+1], filename[100];
        
        strcpy(filename, "/proc/");
        strcat(filename, pid);
        strcat(filename, file);
        
        fd = open(filename, O_RDONLY);
        if (likely(fd == -1)) 
           return -1;
        count = read(fd, aux, sizeof(aux));
        if (likely(count == -1)) 
            return -1;
        
        close(fd);
        aux[count] = '\0';       
        strcpy(file, aux);    
        return 0;
}



//***************************************************************
// Create the command to record in the /proc/oom

void pidstostr(struct pids_t **list, char *pids)
{
        
        struct pids_t *current;
        
	strcpy(pids,"");
        while (*list) {
                strcat(pids, (*list)->pids);
                current = *list;
                *list = (*list)->next;
                if ((*list)!=NULL)
                   strcat(pids, " ");
                free(current);      
        }

}


unsigned long cal_points(char *pid)
{
        unsigned long points, cpu_time, run_time, s, uptime, utime,
stime, start_time;
        char stat[1024], result[1024]; //data
        
        strcpy(stat, "/oom") ;
        get_file(stat, pid);
        utime = strtoul(get_field(stat, 2, result), NULL, 10);
        stime = strtoul(get_field(stat, 3, result), NULL, 10);
              
        strcpy(stat, "/stat") ;
        if (get_file(stat, pid) == -1)
                goto failed;
        
        points = strtoul(get_field(stat, 23, result), NULL, 10)/4096;
//vsize
        if (points==0)
          return 0;
        
        cpu_time = (utime + stime) >> 13; //utime
        
        strcpy(result, "/uptime");
        if (get_file(result, "") == -1)
                goto failed;
        
        uptime = (strtoul(get_field(result, 1, result), NULL, 10)) *
100; //jiffies
        start_time = (strtoul(get_field(stat, 22, result), NULL, 10));
        if(uptime >= start_time)
                run_time = ((uptime - start_time) >> 10)/100;
        else
                run_time = 0;
        
        s = sqrt(cpu_time);

        if (s)
                points /= s;
        s = sqrt (sqrt (run_time));

        if (s)
                points /= s;
        
        if (strtol(get_field(stat, 19, result),NULL,10) > 0)//nice
                points*=2;
        
        strcpy(result, "/status") ;
        
        if (get_file(result, pid) == -1)
                goto failed;
        
        find_field(result, stat, "CapEff"); 
        
        s = strtoul(stat , NULL, 16) ;
        find_field(result, stat, "Uid");
        
        //Superuser process
        if (s & (1 << (CAP_SYS_ADMIN)) || 
            atoi(get_field (stat, 1, result)) == 0 || 
            atoi(get_field (stat, 2, result)) == 0)
                points /=4;
        
        //Process with direct hardware access
        if (s & (1 << (CAP_SYS_RAWIO)))
                points /=4;
               return (points);
        
  failed:
        return -1;
        
}

int write_to_file(char *fname,char *pids)
{
        pid_t child_pid;
        int fd, i;
        ssize_t count;
        
        fd = open(fname, O_WRONLY | O_TRUNC);
        if (fd == -1) {
                int error_code = errno;
                fprintf(stderr, "Error opening file: %s\n",
strerror(error_code));
                return -1;
        }
        count = write(fd, pids, strlen(pids));
        if (count == -1) {
                int error_code = errno;
                fprintf(stderr, "Error writing file: %s\n",
strerror(error_code));                return -1;
        }
        close(fd);
 return 0;
}

unsigned long get_mem(char *type)
{
  char memfile[1025], buffer[100];
  
  strcpy (memfile, "/meminfo");
  get_file(memfile, "");
  find_field(memfile, buffer, type);
  return (strtoul(buffer , NULL, 10) );
}

int get_cmdline(char *pid, char *cmd)
{
 char file[200];
 
 strcpy (file, "/cmdline"); 
 if(get_file(file, pid)==-1)
  return 0;
 
 if ((strstr(file,cmd))==NULL)
   return 0;
 else 
   return 1;  
 
}

int main(void)
{       
        struct pids_t *list = NULL, aux;
        DIR* dir;
        struct dirent* entry;
        int ranking;
        char pids[10025];
        int pid =(int)getpid();
       // ranking = 0 - normal
       // ranking = 1 - oom - ranking once
      
       // free<2%Total
        ranking = 0;
        for(;;) {
         if (get_mem("MemFree") <= (0.02*get_mem("MemTotal"))) // 
         {
   
          if (ranking == 0)
          {  
                
                dir = opendir("/proc");
                while ((entry = readdir(dir)) != NULL) {
                        if (likely(likely(*entry->d_name > '0') &&
likely(*entry->d_name <= '9'))) {
                                if (atoi(entry->d_name) != pid) {
                                     if (!(get_cmdline(entry->d_name,
"klogd") || get_cmdline(entry->d_name, "syslogd")))
                                     {
                                        strcpy(aux.pids, entry->d_name);
                                        if ((aux.points =
cal_points(aux.pids)) >= 0)
                                                insert_list(&list, aux);
                                                
                                                  
                                     }  
                                }
                        }
                }
               
                closedir(dir);
                pidstostr(&list, pids);
                write_to_file("/proc/oom",pids);
                ranking = 1;
                
           }  
          }  
          else
            ranking = 0;   
        }
        return 0; 
}

BR,

Mauricio Lin.
